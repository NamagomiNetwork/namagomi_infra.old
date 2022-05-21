#!/bin/bash
set -e

# proxmox上でローカルIPを確認できるツールをインストール
sudo apt update && sudo apt-get install qemu-guest-agent jq -y

# とりあえず最新に
sudo apt upgrade -y

# 日本時間
sudo timedatectl set-timezone Asia/Tokyo

echo 初期設定完了
echo =====VM情報=====
echo "======================================"
echo "Memstatus: "
free -h
echo "DiskStatus: "
df -h
echo "======================================"
echo "hostname: "
hostname
echo "======================================"
echo "TimeData: "
timedatectl status
echo "======================================"
echo "network status: "
ip a
echo =====VM情報=====

exit 0