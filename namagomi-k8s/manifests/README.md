# manifests

生ゴミ鯖の kubernetes クラスタ定義を管理するディレクトリです

# LoadBalancer のIP割り当て

## 外部接続が必要な LoadBalancer

httpの外部アクセスは `cloudflared` によるトンネルでアクセスできるようになっています<br>

ただし、TCPによるアクセスは、ルーターからLoadBalancerIPへポートフォワードが設定されています

ポートフォワードされているサービスは以下のとおりです

> velocityとはマイクラサーバーとサーバーの中継に使用するサーバーです

| サービス | IPアドレス |
| -- | -- |
| velocity(本番用) | 192.168.35.1 |
| velocity(検証環境用) | 192.168.35.2 |

## 内部LoadBalancer

velocityより接続される各マインクラフトサーバーなどにもLoadBalancerIPが振られています

下記が内部で使用しているサービス一覧です

| サービス | IPアドレス |
| -- | -- |
| Minecraft forge server 1.12.2(本番用modサーバー) | 192.168.35.10 |
| Minecraft forge server 1.12.2(検証用modサーバー) | 192.168.35.11 |
| Minecraft spigot server 1.12.2(本番用spigotサーバー) | 192.168.35.12 |
| Minecraft spigot server 1.12.2(検証用spigotサーバー) | 192.168.35.13 |
| Minecraft spigot server 1.16.5(本番用spigotロビーサーバー) | 192.168.35.14 |
| MinIO | 192.168.35.20 |