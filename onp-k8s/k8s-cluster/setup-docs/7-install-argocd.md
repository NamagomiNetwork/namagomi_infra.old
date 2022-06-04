# ArgoCDのインストール

このドキュメントではArgoCDをインストールします

- namespace `argocd` を作成します

```
kubectl create namespace argocd
```

- ArgoCDをデプロイします

```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.3.4/manifests/install.yaml
```

- パスワードを確認します

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```