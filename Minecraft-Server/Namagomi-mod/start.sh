#!/bin/sh

cd /home/mc-server/mc
screen -UAmdS mc java -server -Xmx10G -Duser.timezone=JST -jar server.jar