# クラスタのセットアップ

## 前提環境

- `Proxmox VE 7.2`
- `Mem48GB以上`
- `CPU10コア以上`
- `ストレージ300GB以上`

## VMのデプロイ

> この工程はproxmox上で実行してください

下記の要件通りにVMを作成します

| Host Name | CPU | Mem | Storage | IP |
| -- | -- | -- | --| --|
| master-1 | 2 | 8GB | 40GB | 192.168.8.1 |
| worker-1 | 4 | 16GB | 130GB | 192.168.8.11 |
| worker-2 | 4 | 32GB | 130GB | 192.168.8.12 |

## クラスターのプロビジョニング

### 前提要件

- 上記の通りにVMを作成すること
- 各Nodeに対しrootユーザーでsshアクセスをできること

> この工程はmaster-1で行ってください

- rootユーザーに切り替えます

```
sudo -s
```

- リポジトリをcloneします

```
git clone https://github.com/NamagomiNetwork/namagomi_infra.git
```

- スクリプトを実行します

```
bash namagomi_infra/namagomi-k8s/cluster-setup/scripts/setup-cluster.sh