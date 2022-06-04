# コンテナランタイムのインストール

本セットアップでは containerd をインストールします

- バイナリをダウンロードします

```
wget -q --show-progress --https-only --timestamping \
  https://github.com/opencontainers/runc/releases/download/v1.1.2/runc.amd64 \
  https://github.com/containerd/containerd/releases/download/v1.5.12/containerd-1.5.12-linux-amd64.tar.gz \
  https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
```

- containerdをインストールします

```
sudo tar Cxzvf /usr/local containerd-1.5.12-linux-amd64.tar.gz
```

- systemdユニットファイル `containerd.service` を作成します

```
wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo mv ./containerd.service /etc/systemd/system/containerd.service
```

- containerdの起動をします

```
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
```

- runcをインストールします

```
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
```

- CNIプラグインをインストールします

```
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
```

Next: [kubeadmなどのインストール](./4-install-kubeadm.md)