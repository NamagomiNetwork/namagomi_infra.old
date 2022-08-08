#!/bin/bash

echo "このスクリプトは、生ゴミ鯖k8sクラスタを自動構築するスクリプトです"
echo "途中設定する項目があります"
echo ""
    if [ "$EUID" -ne 0 ]
    then echo "root権限がありません。sudoで実行をするかrootユーザーに切り替えてください"
    exit 1
    fi

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
kubeadm init --pod-network-cidr 10.244.0.0/16 --control-plane-endpoint=192.168.8.1 --apiserver-advertise-address=192.168.8.1

# kubectlを叩けるように
mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /root/.kube/config
# shellcheck disable=SC2046
chown $(id -u):$(id -g) /root/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf

# シングルノード運用するためmasterにpodを配置するように

kubectl taint nodes --all node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master-

# podネットワークアドオンのインストール
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

# 30秒待ってget nodesを取得する
sleep 30
kubectl get nodes

echo "master nodeのセットアップが完了しました"

cat <<EOF | sudo tee /root/worker-setup.sh
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

cat <<1_EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
1_EOF

cat <<2_EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
2_EOF

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
EOF

echo "rootユーザーにパスワードなしでアクセスするために秘密鍵を登録します。rootユーザーに対してパスワードによるsshアクセスが可能にしたあと文字を入力すると処理を続行します"
read -r CONFIRM_ROOT_SSH_ACCESS

echo "ssh秘密鍵を生成します。すべてなにも変更せずにEnterを押してください"

ssh-keygen -t ed25519

for node in 192.168.8.11 192.168.8.12; do
  ssh-copy-id -i /root/.ssh/id_ed25519.pub root@${node}
done

for node in 192.168.8.11 192.168.8.12; do
  sudo scp -i /root/.ssh/id_ed25519 /root/worker-setup.sh root@${node}:~/
done

# 各Nodeにkubeadmなどをインストール
for node in 192.168.8.11 192.168.8.12; do
  ssh -i /root/.ssh/id_ed25519 root@${node} bash /root/worker-setup.sh
done

# クラスターに参加できるコマンドを保存
kubeadm token create --print-join-command >> /root/join.sh

# クラスターに参加する

## join.shをぶんまわす
for node in 192.168.8.11 192.168.8.12; do
  sudo scp -i /root/.ssh/id_ed25519 /root/join.sh root@${node}:~/
done

## join.shを実行
for node in 192.168.8.11 192.168.8.12; do
  ssh -i /root/.ssh/id_ed25519 root@${node} bash /root/join.sh
done

echo "クラスターの参加処理が完了しました。ArgoCDのデプロイ及び設定を行います"
# 30秒待ってやる！
sleep 30

# Nodeを取得
kubectl get nodes

# argocdをデプロイ

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.6/manifests/install.yaml

# またまた30秒まつ
sleep 30

# github Oauthの設定
echo "GithubのOauth設定を行います"
echo "Client_IDを入力してください"
read -r GITHUB_CLIENT_ID
echo "Client_Secretを入力してください"
read -r GITHUB_CLIENT_SECRET

cat <<EOF | sudo tee /root/argocd-cm.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-cm
data:
  # cloudflaredを設定し、外部からアクセスできるようになったらadminアカウントを無効化すべき
  #admin.enabled: "false"
  dex.config: |
    connectors:
      - type: github
        id: github
        name: GitHub
        config:
          clientID: "$GITHUB_CLIENT_ID"
          clientSecret: "$GITHUB_CLIENT_SECRET"
          orgs:
          - name: NamagomiNetwork
  url: https://namagomi-argocd.nabr2730.com
EOF

cat <<EOF | sudo tee /root/argocd-rbac-cm.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: argocd-rbac-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-cm
data:
  policy.csv: |
    g, NamagomiNetwork:infra_admins, role:admin
    g, admin, role:admin
  policy.default: role:readonly
EOF

# apply
kubectl apply -f argocd-rbac-cm.yaml
kubectl apply -f argocd-cm.yaml

# お掃除
rm -f argocd-cm.yaml argocd-rbac-cm.yaml

# つうち
echo "セットアップが完了しました！"