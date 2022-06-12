#!/bin/bash

# ホワイトリスト作成スクリプト

echo "この スクリプトは、github上のwhitelist.jsonに追記するスクリプトです"
echo "Warning: 既存のwhitelist.jsonは削除されます！"
read -p "mcidを入力してください: " MCID
echo "$MCIDをホワイトリストに追加します"

# ほわりすをgit上のものに
rm whitelist.json
wget https://raw.githubusercontent.com/NamagomiNetwork/namagomi_infra/main/Minecraft-Server/Namagomi-mod/configs/whitelist.json

# 情報を取得する
curl https://api.mojang.com/users/profiles/minecraft/$MCID | jq '{name, "uuid": ([. | tostring | match("([a-f0-9]{8})([a-f0-9]{4})([a-f0-9]{4})([a-f0-9]{4})([a-f0-9]{12})") | .captures[] | .string] | join("-"))}' >> "./whitelist.tmp"

# 下2行を削除(jsonの整形をするため)
sed -i '$d' ./whitelist.json
sed -i '$d' ./whitelist.json

# 整形のために追記
echo "}," >> whitelist.json

# 取得したユーザー情報を書き込む

cat ./whitelist.tmp >> ./whitelist.json

#tmpは消す
rm -f whitelist.tmp

# 整形のために追記
echo "]" >> whitelist.json

echo "=====ここから====="
cat whitelist.json
echo "=====ここまで====="
echo "ユーザー $MCID のホワイトリスト追加処理が完了しました。"
echo "gitには上記のものに更新してください"