#!/bin/bash
set -e

# root以外を弾く
if [ "$EUID" -ne 0 ]
    then echo "root権限がありません。sudoをつけるかrootユーザーに切り替えてください"
    exit 1
fi

## APT update
apt update
apt upgrade -y
