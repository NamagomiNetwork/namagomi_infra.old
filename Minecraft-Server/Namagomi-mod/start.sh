#!/bin/sh

cd /home/mc-server/mc || exit
# 各種configはgithubから引っ張る
rm ops.json server.properties whitelist.json
wget -q --show-progress --https-only --timestamping \
  https://raw.githubusercontent.com/NamagomiNetwork/namagomi_infra/main/Minecraft-Server/Namagomi-mod/configs/ops.json \
  https://raw.githubusercontent.com/NamagomiNetwork/namagomi_infra/main/Minecraft-Server/Namagomi-mod/configs/server.properties \
  https://raw.githubusercontent.com/NamagomiNetwork/namagomi_infra/main/Minecraft-Server/Namagomi-mod/configs/whitelist.json

screen -UAmdS mc java -server -Xmx10G -Duser.timezone=JST -jar server.jar