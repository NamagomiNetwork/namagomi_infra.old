# docker-Installer

## はじめに
このスクリプトでは、dockerおよびdocker-composeをShellscript1つで導入するためのものです

## 依存関係

- `apt`
- `wget`

# インストール

## コマンド
上記から順に実行してください

```
wget https://raw.githubusercontent.com/NanairoServerNetwork/nanairo_server_infra/main/scripts/setups/docker-setup.sh
sudo bash docker-setup.sh {アーキテクチャ名}
```
このコマンドでdocker並びにdocker-composeをインストールできます

## アーキテクチャ名について

まず`uname -m` コマンドを実行してください

### x86_64やamd64などが表示された場合

アーキテクチャ名の部分には `amd64` と入力してください

### aarch64と表示された場合

アーキテクチャ名の部分には `arm64` と入力してください

### armv7と表示された場合

アーキテクチャ名の部分には `armv7` と入力してください

### armv6と表示された場合

アーキテクチャ名の部分には `armv6` と入力してください


# 注意事項

- armv7,armv6の環境を所持していないため動かない可能性があります。
- 個人用に作成したもののため処理ががさつです ~~許してくださいなんでも(ry~~