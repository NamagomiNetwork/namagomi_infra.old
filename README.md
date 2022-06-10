# Namagomi_infra

生ゴミ鯖のインフラを管理するリポジトリです。

## ディレクトリ構成

- [`onp-k8s`](./onp-k8s/)
    - オンプレ環境のk8sを管理するディレクトリ
    - Secretの管理に気をつけてください
- [`docker`](./docker/)
    - DockerImageを管理するディレクトリ
    - 現在は下記のイメージを管理しています
        - [Namagomi-Velocity](https://github.com/NamagomiNetwork/namagomi_infra/pkgs/container/namagomi-velocity)
- [`scripts`](./scripts/)
    - このディレクトリでは、自動構築スクリプトなど雑なスクリプトを管理するディレクトリ
- [`docs`](./docs/)
    - このディレクトリでは、スクリプトやdockerImageの解説,使い方等を管理するディレクトリ
- [`Minecraft_Server`](./Minecraft-Server/)
    - マイクラ鯖の設定を管理するディレクトリ
    - configやスクリプトなどを管理しています

## k8sクラスタのSecret管理について

k8s上に配置されるアプリケーションのSecretは、 [ArgoCD Vault Plugin](https://github.com/argoproj-labs/argocd-vault-plugin), [AWS Secret Manager](https://aws.amazon.com/jp/secrets-manager/) で管理しています。Secretが必要となる場合インフラ管理者にお問い合わせください<br>
また、Secretの注入方法は [README](./onp-k8s/k8s-cluster/docs/Secret.md) を閲覧してください