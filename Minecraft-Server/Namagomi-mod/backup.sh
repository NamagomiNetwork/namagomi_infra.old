#!/bin/bash

DATE=$(/usr/bin/date "+%Y-%m-%d-%H-%M")


/usr/bin/screen -S mod01 -X stuff "say =======================================\015"
/usr/bin/screen -S mod01 -X stuff "say サーバーは10分後に再起動します\015"
/usr/bin/screen -S mod01 -X stuff "say くらえ！\015"
/usr/bin/screen -S mod01 -X stuff "say =======================================\015"

/usr/bin/sleep 300

/usr/bin/screen -S mod01 -X stuff "say =======================================\015"
/usr/bin/screen -S mod01 -X stuff "say サーバーは5分後に再起動します\015"
/usr/bin/screen -S mod01 -X stuff "say くらえ！\015"
/usr/bin/screen -S mod01 -X stuff "say =======================================\015"

/usr/bin/sleep 180

/usr/bin/screen -S mod01 -X stuff "say =======================================\015"
/usr/bin/screen -S mod01 -X stuff "say サーバーは2分後に再起動します\015"
/usr/bin/screen -S mod01 -X stuff "say くらえ！\015"
/usr/bin/screen -S mod01 -X stuff "say =======================================\015"

/usr/bin/sllep 60

/usr/bin/screen -S mod01 -X stuff "say =======================================\015"
/usr/bin/screen -S mod01 -X stuff "say サーバーは1分後に再起動します\015"
/usr/bin/screen -S mod01 -X stuff "say くらえ！\015"
/usr/bin/screen -S mod01 -X stuff "say =======================================\015"

/usr/bin/sleep 30

/usr/bin/screen -S mod01 -X stuff "say =======================================\015"
/usr/bin/screen -S mod01 -X stuff "say サーバーは30秒後に再起動します\015"
/usr/bin/screen -S mod01 -X stuff "say くらえ！\015"
/usr/bin/screen -S mod01 -X stuff "say =======================================\015"

/usr/bin/sleep 20

/usr/bin/systemctl stop mod
if [ ! -d /home/mcserver/minecraft/backup ]
then
    /usr/bin/mkdir /home/mcserver/minecraft/backup
    /usr/bin/echo "ディレクトリが存在しなかったため作成しました"
    /usr/bin/sleep 3
fi

/usr/bin/tar -zcvf /home/mcserver/minecraft/backup/mc-backup-"${DATE}".tar.gz /home/mcserver/minecraft/mod


/usr/bin/echo "バックアップ成功でやんす"

/usr/bin/systemctl start mod