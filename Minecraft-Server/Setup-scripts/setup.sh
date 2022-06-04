#!/bin/bash

echo "mc-serverというユーザーは作成されていますか？"
echo "mc-serverユーザーが存在しない場合処理は失敗します。"
echo "作成コマンド: adduser mc-server"
echo "ユーザーmc-serverが存在し処理を続行しますか？: [Y/N]"

read -r ANS

case $ANS in
  [Yy]* )
    # rootかどうか確かめる
    if [ "$EUID" -ne 0 ]
    then echo "root権限がありません。sudoをつけるかrootユーザーに切り替えてください"
    exit 1
    fi

    echo "Java8をインストールします..."
    sudo apt install openjdk-8-jre-headless -y
    echo "Javaのインストールが完了しました"

    sudo -u mc-server mkdir /home/mc-server/mc
    sudo -u mc-server wget https://raw.githubusercontent.com/NamagomiNetwork/namagomi_infra/main/Minecraft-Server/Setup-scripts/forge.sh
    sudo -u mc-server bash forge.sh
    echo "done!"
    ;;
  * )

    echo "処理を中断します..."
    ;;
esac