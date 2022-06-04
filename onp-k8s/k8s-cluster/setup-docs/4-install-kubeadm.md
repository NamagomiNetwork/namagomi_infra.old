# kubeadm、kubelet、kubectlのインストール

- kubeadmのインストールに必要な関連パッケージをインストールします

```
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl
```

- gpgキーをダウンロードします

```
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
```

- リポジトリを追加します

```
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

- パッケージリストを更新します

```
sudo apt update
```

- kubelet kubeadm kubectlをインストールします

```
sudo apt-get install -y kubelet kubeadm kubectl
```

- kubelet kubeadm kubectlをアップデートしないように設定します

```
sudo apt-mark hold kubelet kubeadm kubectl
```

Next: [kustomize及びHelmのインストール](./5-install-kustomize-helm.md)