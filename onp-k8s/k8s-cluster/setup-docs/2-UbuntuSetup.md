# ubuntuのセットアップ

時刻の設定やパッケージリストの更新等を行います

- パッケージリストの更新及びシステムの最新化を行います

```
sudo apt-get update && sudo apt-get upgrade -y
```

- rootパスワードを設定します

```
sudo passwd root
```

- 日本時間に時刻設定を切り替えます

```
sudo timedatectl set-timezone Asia/Tokyo
```

- swapを無効化します

> **WARNING**: swapが無効でないと正しくkubeletが動作しません

```
sudo sed -i /swap/s/^/#/g /etc/fstab && cat /etc/fstab | grep swap
```

実行結果がこのようになっている場合無効化に成功しています
```
nabr@master-1:~$ sudo sed -i /swap/s/^/#/g /etc/fstab && cat /etc/fstab | grep swap
#/swap.img      none    swap    sw      0       0
```

- iptablesがブリッジを通過するトラフィックを処理できるようにします

```
sudo modprobe br_netfilter
sudo modprobe overlay

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
```

- 各種設定を反映するために再起動を行います

```
sudo reboot
```

Next: [コンテナランタイムのインストール](./3-install-CRI.md)