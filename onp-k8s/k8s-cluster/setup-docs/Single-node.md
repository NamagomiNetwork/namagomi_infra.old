# シングルノードでのk8sクラスタ作成

ほんドキュメントでは、シングルノードでk8sを触れる用に構築を行います

## 前提要件

- 多少のubuntuの知識

## IPアドレスについて

**必ず** 固定IPにしてください。<br>

### インストール方法

このコマンドを実行したらあとは自動で構築されます

```
sudo -s
wget https://raw.githubusercontent.com/NamagomiNetwork/namagomi_infra/main/onp-k8s/k8s-cluster/setup-scripts/k8s-single-install.sh
chmod +x k8s-single-install.sh
./k8s-single-install.sh
```

> ./k8s-single-install.sh を実行後IPアドレスを入力してください

## その他

- 結局Workerノードを追加したい！ってなったら？
    - `kubeadm token create --print-join-command` を実行し、出てきたコマンドを実行してください
