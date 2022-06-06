# ks8-cluster

オンプレ環境にk8sクラスタをデプロイするるための設定やスクリプト類です

# 前提環境

- Proxmox Virtual Environment 7.2-4

### VM一覧

|名前|役割|vCPU|RAM|Storage|IP|
|--|--|--|--|--|--|
|master|master|2|4GB|32GB|192.168.8.10/16|
|worker-1|worker|2|4GB|32GB|192.168.8.20/16|
|worker-2|worker|2|4GB|32GB|192.168.8.21/16|
|worker-3|worker|2|4GB|32GB|192.168.8.22/16|

## IP設計

- sub-net: 192.168.0.0/16
- Gateway: 192.168.0.254

- DHCP範囲: 192.168.11.1-192.168.11.254
- Minecraft_Server: 192.168.2.1-192.168.2.254
    - Namagomi_mod: 192.168.2.1
- k8s-Network
    - k8s-pod-Network: 10.244.0.0/16
    - k8s-cluster-Network: 192.168.8.1-192.168.8.254
    - k8s-LoadBalancer-Network: 192.168.30.1-192.168.32.254
    - API-Endpoint: 192.168.8.10
- Storage-Network(192.168.10.1-192.168.10.254)
    - synology DiskStation DS1621+(Main_Storage): 192.168.10.1
    - synology DiskStation DS420+ (Backup_Storage): 192.168.10.2
- Hard-Network(192.168.1.1-192.168.1.254)
    - prox13-sv-nabr(DeskminiX300): 192.168.1.150
    - prox14-sv-nabr(DeskminiX300): 192.192.1.151
    - prox15-sv-nabr(DeskminiX300): 192.192.1.152

## k8sクラスタの構築

本ドキュメントは、Kubernetes v1.24 時点の構築メモです。バージョンによって本構築ドキュメント通りでは構築できなくなる可能性があることをご注意ください<br>

Next: [VMのセットアップ](./setup-docs/1-VMSetup.md)

### もくじ

- [VMのセットアップ](./setup-docs/1-VMSetup.md)
- [Ubuntuの初期設定](./setup-docs/2-UbuntuSetup.md)
- [コンテナランタイムのインストール](./setup-docs/3-install-CRI.md)
- [kubeadmなどのインストール](./setup-docs/4-install-kubeadm.md)
- [kustomize及びHelmのインストール](./setup-docs/5-install-kustomize-helm.md)
- [クラスターの作成](./setup-docs/6-create-cluster.md)
- [ArgoCDのインストール](./setup-docs/7-install-argocd.md)


## 番外編

- [シングルノードでk8sを導入する](./setup-docs/Single-node.md)