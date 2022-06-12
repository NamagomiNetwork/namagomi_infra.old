#!/bin/bash

# ホワイトリスト作成スクリプト

echo "この スクリプトは、whitelist.jsonに追記するスクリプトです"
read -p "mcidを入力してください: " MCID
echo "$MCIDをホワイトリストに追加します"

# 既存のwhitelist.jsonがある前提なので削除
if [ ! -e ./whitelist.json ];then
    echo "whitelist.jsonが見つかりません"
    echo "本スクリプトは既存のwhitelist.jsonがあることを前提としています    "
    exit 1
fi

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

echo "ユーザー $MCID のホワイトリスト追加処理が完了しました。"
read -p "追加されたホワイトリストを確認しますか(y/n): " CHECKLIST
case "$CHECKLIST" in
  [yY]) cat ./whitelist.json ;;
  [nN]) echo "Done!" ;;
  *) echo "yもしくはnでなかったため保存されたホワイトリストは表示しません"
esac