#!/bin/bash

set -e

cd /server

# ===== 環境変数 =====
MAX_MEM=${MAX_MEM}
VELOCITY_URL=${VELOCITY_URL}
VELOCITY=${VELOCITY_JARNAME}
CLOUDFLARED_IP=${CLOUDFLARED_IP}
SERVER_ICON=${SERVER_ICON}
# ================


# 各種ダウンロード
wget ${VELOCITY_URL}
wget ${SERVER_ICON}


# 各種ファイルがない場合そこで起動処理をとめる
if [ ! -e ${VELOCITY_JARNAME} ];then
    echo "${VELOCITY_JARNAME} が見つかりません。"
    echo "ダウンロードしたファイルと ${VELOCITY_JARNAME} に指定した名前が同じか確かめてください"
    exit 1
fi

if [ ! -e velocity.toml ];then
    echo "velocity.toml が見つかりません。"
    echo "docker-compose.ymlでvelocity.tomlを指定してください"
    exit 1
fi

java -Xmx${MAX_MEM} -Duser.timezone=JST -jar ${VELOCITY_JARNAME}