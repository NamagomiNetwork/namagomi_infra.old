# VMのセットアップ

本セットアップでは、VMのデプロイを行います。

## VMの作成

前提要件の通りにVMを作成します。

|名前|役割|vCPU|RAM|Storage|IP|OS|
|--|--|--|--|--|--|--|
|master|master|2|4GB|32GB|192.168.8.10/16|ubuntu20.04|
|worker-1|worker|2|4GB|32GB|192.168.8.20/16|ubuntu20.04|
|worker-2|worker|2|4GB|32GB|192.168.8.21/16|ubuntu20.04|
|worker-3|worker|2|4GB|32GB|192.168.8.22/16|ubuntu20.04|

### ubuntuのインストール

インストーラー通りにubuntuのインストールを進行します。<br>
IPアドレスの設定部分はmasterNodeの場合は下記のように設定します(本環境と全くおなじにする場合)

- IPアドレスを下記のように静的IPに切り替えます
<br>
![ip_settings](https://i.gyazo.com/59ef2aa151de1438b39607a5dbce4470.png)

全ノードのインストールが完了したら次のセットアップに進みます

Next: [Ubuntuの初期設定](./2-UbuntuSetup.md)