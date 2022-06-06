#!/bin/bash

echo "このスクリプトは、シングルノードでのk8sを構築する自動スクリプトです。"
echo "また、ArgoCDなども導入します。"
echo "sudoで実行しないでください!!!かならずsudo -s などを使用してrootユーザーに切り替えてください!"
echo "このサーバーのIPアドレスを入力してください(例: 192.168.3.254)"
read -r IP
echo ""
    if [ "$EUID" -ne 0 ]
    then echo "root権限がありません。sudoをつけるかrootユーザーに切り替えてください"
    exit 1
    fi

echo "入力されたIPアドレス: $IP で処理を実行します..."
echo "10秒後に処理が開始されます...中断は  ctrl + Cを実行してください"
sleep 10


# 処理実行

# パッケージリスト更新
sudo apt-get update && sudo apt-get upgrade -y

# 日本時間に切り替える
sudo timedatectl set-timezone Asia/Tokyo
timedatectl

# swapの無効化
# kubeletの計算が正しく行われなく可能性があるため
sudo sed -i "/swap/s/^/#/g" /etc/fstab

# iptablesがブリッジを通過するトラフィックを処理できるように

sudo modprobe br_netfilter
sudo modprobe overlay

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

# 再起動しないとfstabは意味ないので一時敵に無効化
swapoff -a

# containerdのインストール

wget -q --show-progress --https-only --timestamping \
  https://github.com/opencontainers/runc/releases/download/v1.1.2/runc.amd64 \
  https://github.com/containerd/containerd/releases/download/v1.5.12/containerd-1.5.12-linux-amd64.tar.gz \
  https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz

# install containerd
sudo tar Cxzvf /usr/local containerd-1.5.12-linux-amd64.tar.gz

wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo mv ./containerd.service /etc/systemd/system/containerd.service

sudo systemctl daemon-reload
sudo systemctl enable --now containerd

sudo install -m 755 runc.amd64 /usr/local/sbin/runc

sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz

# kubeadm、kubelet、kubectlのインストール

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# kustomizeとHelmのインストール
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install helm -y
sudo curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
sudo mv ./kustomize /usr/bin

# クラスタの構築
kubeadm init --pod-network-cidr 10.244.0.0/16 --control-plane-endpoint="${IP}" --apiserver-advertise-address="${IP}"

# kubectlを叩けるように
mkdir -p "$HOME"/.kube
cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
# shellcheck disable=SC2046
chown $(id -u):$(id -g) "$HOME"/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf

# シングルノード運用するためmasterにpodを配置するように

kubectl taint nodes --all node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master-

# podネットワークアドオンのインストール
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

# 30秒待ってget nodesを取得する
sleep 30
kubectl get nodes

# ArgoCDのインストール
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.3.4/manifests/install.yaml

echo "インストールが完了しました"

echo "ArgoCDのパスワード: " kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
echo "このパスワードは kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo を実行することで再度取得できます"
