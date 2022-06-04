# クラスタの作成

このドキュメントでは、クラスタを作成します

## 前提要件

- 本セットアップドキュメントのすべての工程を終えていること
- ネットワークの構成が [前提要件](../README.md) 通りであること

# クラスタの構築

## MasterNodeの構築
- `masterNode`となるもので下記のコマンドを実行します

> NOTE: この操作はrootユーザーで行う必要があります

```
kubeadm init --pod-network-cidr 10.244.0.0/16 --control-plane-endpoint 192.168.8.10 --apiserver-advertise-address=192.168.8.10
```

成功するとこのような出力が出るので `kubeadm join 192.168.8.10:6443....` の部分をメモしてください

```
Your Kubernetes control-plane has initialized successfully!

～～省略～～

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join 192.168.8.10:6443 --token 5ub9d2.1t8vltlwto7rpxqp \
        --discovery-token-ca-cert-hash sha256:4e91b4da19de115b1207c76770db700e2841f065c049d48a37dad83fa8e7cc08 \
        --control-plane

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.8.10:6443 --token 5ub9d2.1t8vltlwto7rpxqp \
        --discovery-token-ca-cert-hash sha256:4e91b4da19de115b1207c76770db700e2841f065c049d48a37dad83fa8e7cc08
```

### 注意点

tokenはデフォルトの状態では24時間で失効します。TOKENを再生成する場合下記のコマンドを実行します

```
kubeadm token create --print-join-command
```

## WorkerNodeの構築
- `WorkerNode`となるもので下記のコマンドを実行します

> NOTE: TOKENの値等は異なります
```
kubeadm join 192.168.8.10:6443 --token 5ub9d2.1t8vltlwto7rpxqp \
        --discovery-token-ca-cert-hash sha256:4e91b4da19de115b1207c76770db700e2841f065c049d48a37dad83fa8e7cc08
```

## kubectlコマンドを実行するための準備

### masterNodeでkubectlを実行する場合

masterNodeでkubectlを実行する必要がある場合コマンドを実行するユーザーで下記コマンドを実行します

```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### 別の場所から`kubectl`コマンドを実行する場合


masterNodeで下記コマンドを実行し保存します

```
cat /etc/kubernetes/admin.conf
```

### 結果: 
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ながい
    server: https://192.168.8.10:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: ながい
    client-key-data: ながい
```

その後 ~/.kube/config に保存します


### アクセスできるか確認

`kubectl get nodes` コマンドを実行し、クラスタにアクセスできるか検証を行います

```
root@master-1:~# kubectl get nodes
NAME       STATUS     ROLES           AGE     VERSION
master-1   NotReady   control-plane   12m     v1.24.1
worker-1   NotReady   <none>          5m50s   v1.24.1
worker-2   NotReady   <none>          5m23s   v1.24.1
worker-3   NotReady   <none>          5m19s   v1.24.1
```

## Podネットワークアドオンのインストール

次のコマンドを実行しPodネットワークアドオンをデプロイします

```
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

再度 `kubectl get nodes` を実行し statusがReadyになっていることを検証してください

```
root@master-1:~# kubectl get nodes
NAME       STATUS   ROLES           AGE   VERSION
master-1   Ready    control-plane   21m   v1.24.1
worker-1   Ready    <none>          15m   v1.24.1
worker-2   Ready    <none>          14m   v1.24.1
worker-3   Ready    <none>          14m   v1.24.1
```

Next: [ArgoCDのインストール](./7-install-argocd.md)