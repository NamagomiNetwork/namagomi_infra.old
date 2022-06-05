#!/bin/sh

cd /home/mc-server/mc || exit
# 各種configはgithubから引っ張る
screen -UAmdS mc java -server -Xmx10G -Duser.timezone=JST -jar server.jar