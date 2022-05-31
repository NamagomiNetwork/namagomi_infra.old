# nanairo-velocity

このdocker imageは Minecraftプロトコル用のProxyサーバー [Velocity](https://velocitypowered.com/) をDockerで使用できるよう生ゴミ鯖向けに作成したものです

## サーバーアイコンについて

[サーバーアイコン](https://github.com/NamagomiNetwork/icon) をダウンロードする用に設定されています。このイメージを使用される際は、`docker/namagomi-velocity/sample-config/docker-compose.yml` の変数 `SERVER_ICON` を置き換えてください

## velocity.tomlについて

- velocity.tomlがコンテナ内の `/server/velocity.toml` に存在しない場合起動が中断されます。