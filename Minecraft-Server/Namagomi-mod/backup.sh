#!bin/bash

DATE=$(date "+%Y-%m-%d-%H-%M")

# mc鯖を停止
sudo systemctl stop mc

if [ ! -d /home/mc-server/mc/backup ]
then
    mkdir /home/mc-server/mc/backup
fi

tar czfP /home/mc-server/mc/backup/mc-backup-${data}.tar.gz /home/mc-server/mc

sudo systemctl start mc