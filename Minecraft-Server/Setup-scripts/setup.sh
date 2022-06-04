#!/bin/bash

echo "mc-serverというユーザーは作成されていますか？"
echo "mc-serverユーザーが存在しない場合処理は失敗します。"
echo "作成コマンド: adduser mc-server"
echo "ユーザーmc-serverが存在し処理を続行しますか？: [Y/N]"

read ANS

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
    sudo -u mc-server cd /home/mc-server/mc
    sudo -u mc-server wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar
    sudo -u mc-server java -jar forge-1.12.2-14.23.5.2860-installer.jar --installServer
    sudo -u mc-server /home/mc-server/mc/forge-1.12.2-14.23.5.2860.jar /home/mc-server/mc/server.jar 
    ;;
  * )

    echo "処理を中断します..."
    ;;
esac