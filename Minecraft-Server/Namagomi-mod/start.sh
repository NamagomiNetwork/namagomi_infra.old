#!/bin/bash
readonly SERVERDIR=`dirname $0`

cd ${SERVERDIR}

/usr/lib/jvm/java-8-openjdk-amd64/bin/java \
  -Dfile.encording=UTF-8 \
  -verbose:gc \
  -server \
  -Xms28G \
  -Xmx28G \
  -XX:MetaspaceSize=512M \
  -XX:+UseG1GC \
  -XX:+UseStringDeduplication \
  -jar server.jar \
  nogui
