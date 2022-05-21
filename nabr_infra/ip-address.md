# IPアドレス設計

## 本番セグメント (192.168.0.0/16 192.168.0.1～192.168.255.254)
| 名称 | IPアドレス | 種別 | 備考 |
| -------- | ------ | ---- | -------- | 
| IX2215 | 192.168.0.254 | ルーター | [config](https://github.com/NanairoServerNetwork/nanairo_server_infra/tree/main/home_infra/router/config) |
| nabr-sv-prox01 | 192.168.1.150 | 物理機(Proxmox) | VERSION: 7.2-3 |
| nabr-sv-prox02 | 192.168.1.151 | 物理機(Proxmox) | VERSION: 7.2-3 |
| nabr-backup-nas1 | 192.168.1.140 | NAS |  |
| nabr-backup-nas2 | 192.168.1.141 | NAS |  |
| nabr-lobby | 192.168.2.11 | VM | VMID: 211 |
| [現行]Worker-0 | 192.168.3.7 | VM | VMID: 307 |
| [廃盤]Worker-0 | 192.168.3.8 | VM | VMID: 308 |
| Worker-1 | 192.168.3.9 | VM | VMID: 309 |
| [バックアップ]network-iap | 192.168.3.11 | VM | VMID: 311 , 機能がWorker-0に移植済み |