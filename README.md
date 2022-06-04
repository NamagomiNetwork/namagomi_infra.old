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