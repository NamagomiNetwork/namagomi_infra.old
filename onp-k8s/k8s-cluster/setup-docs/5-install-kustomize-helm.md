# kustomize及びHelmのインストール

このドキュメントではkustomize及びHelmのインストールを行います

### Helmのインストール

- gpgキーをダウンロードします

```
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
```

- リポジトリを追加します

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
```

- パッケージリストを更新します

```
sudo apt update
```

- helmをインストールします

```
sudo apt install helm -y
```

### kustomizeのインストール

- バイナリをダウンロードします

```
sudo curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
```

- kustomizeをインストールします

```
sudo mv ./kustomize /usr/bin
```

Next: [クラスタの作成](./6-create-cluster.md)