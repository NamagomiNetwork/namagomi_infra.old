# アプリケーションへのSecret注入方法

アプリケーションへのSecretを注入するためにはSecretリソースを作成します

- Secretリソースの例

```
kind: Secret
apiVersion: v1
metadata:
  name: hoge-secret
  annotations:
    avp.kubernetes.io/path: argo/secret
type: Opaque
stringData:
  hoge: <aws_secret_name>
```

- aws_secret_nameにはインフラ管理者より割り当てられたAWSの変数を利用してください
- `avp.kubernetes.io/path: argo/secret` は書き換えないでください(AWSのSecretを参照できなくなります)

Secretリソースを作成できたら通常のアプリケーションと同様にSecretを注入することができます