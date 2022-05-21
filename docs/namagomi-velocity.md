# nanairo-velocity

このdocker imageは Minecraftプロトコル用のProxyサーバー [Velocity](https://velocitypowered.com/) をDockerで使用できるよう生ゴミ向けに作成したものです

## サーバーアイコンについて

[サーバーアイコン](https://github.com/NamagomiNetwork/icon) をダウンロードする用に設定されています。このイメージを使用される際は、`docker/namagomi-velocity/sample-config/docker-compose.yml` の変数 `SERVER_ICON` を置き換えてください

## velocity.tomlについて

- velocity.tomlがコンテナ内の `/server/velocity.toml` に存在しない場合起動が中断されます。
- cloudflardを使用する前提で作成したイメージのため、 `docker-compose.yml` の `CLOUDFLARED_IP` には [cloudflared-access](https://github.com/NamagomiNetwork/cloudflared-access) が動いているコンテナのローカルIPを指定してください
    - 入力したIPはコンテナ内でのみ `velocity.namagomi.cfd.prod` で名前解決ができるため、 velocity.tomlの servers には `velocity.namagomi.cfd.prod` を指定することを推奨します

### `velocity.namagomi.cfd.prod` を指定した例
```toml
[servers]
	lobby = "velocity.namagomi.cfd.prod:30000"
	pvp = "velocity.namagomi.cfd.prod:30001"
	Life = "velocity.namagomi.cfd.prod:30002"
	try = ["lobby"]
```    