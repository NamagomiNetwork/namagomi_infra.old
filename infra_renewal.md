# インフラ環境のリニューアル

### 物理構成

| type | ip_address | hostname | その他 |
| -- | -- | -- | -- |
| 物理サーバー| 192.168.1.10/16 | namagomi-sv-prox01 | OS: Proxmox VE |
| ルーター | 192.168.0.254/16 | namagomi-network-gateway | ルーター, DHCP範囲は192.168.11.1~192.168.11.254 |

### namagomi-sv-prox01の詳細

| OS | ip_address | hostname | CPU | memory | Disk | 備考 |
| -- | -- | -- | -- | --| --| --|
| Proxmox VE | 192.168.1.10/16 | namagomi-sv-prox01 | Ryzen5 5600G | S.O.DIMM DDR4 3200 32GB | SSD: 500GB | メモリ,ディスクは追加予定 |

## ネットワーク

- subnet mask
    - 255.255.0.0 (192.168.0.0/16)
- default gateway
    - 192.168.0.254
- DHCP範囲
    - 192.168.11.1 ~ 192.168.11.254
- 192.168.0.x  
    - ネットワーク機器のエリア
    - ネットワークスイッチなども存在している
- 192.168.1.x
    - 物理サーバーのエリア
    - Deskminiちゃんたちがいる
- 192.168.3.x
    - Proxmox上にいるLXCコンテナのエリア
    - 管理者のアクセス用踏み台及びGrafana,Prometheusを配置している
- 192.168.8.x
    - k8sのVMエリア
    - worker, masterのホストIP
- 192.168.11.x
    - DHCPエリア
    - サーバーに関係するものは配置せず、管理アクセスの際に使用する
- 192.168.30.x-192.168.35.x
    - k8s上のLoadBalancerによって振られるエリア
