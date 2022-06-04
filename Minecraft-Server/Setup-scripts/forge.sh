#!/bin/bash

cd /home/mc-server/mc || exit
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2860/forge-1.12.2-14.23.5.2860-installer.jar
java -jar forge-1.12.2-14.23.5.2860-installer.jar --installServer
mv /home/mc-server/mc/forge-1.12.2-14.23.5.2860.jar /home/mc-server/mc/server.jar 