# Namagomi_infra

生ゴミ鯖のインフラ部分

## ディレクトリ構成

- `nabr_infra`(./nabr_infra/)

    - nabrのおうちのインフラ部分です

- [`proxy`](./proxy/)
    - Minecraftサーバー用プロキシやOnp環境との接続にcloudflaredがあり、その設定類を管理するディレクトリです

- [`scripts`](./scripts/)
    - 自動再起動やサーバー構築を簡単にできる超雑なスクリプト等を管理しています

- [`docs`](./docs/)
    - スクリプトの解説等に使用します

- [`docker`](./docker/) 
    - 中継サーバーなどのdockerImageを管理するディレクトリです