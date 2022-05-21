#!/bin/bash
set -e

# ==================
# docker-composeインストールURL
DOCKER_COMPOSE_AMD64_URL="https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64"
DOCKER_COMPOSE_ARM64_URL="https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-aarch64"
DOCKER_COMPOSE_ARMV7_URL="https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-armv7"
DOCKER_COMPOSE_ARMV6_URL="https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-armv6"
# ==================

# root以外を弾く
if [ "$EUID" -ne 0 ]
    then echo "root権限がありません。sudoをつけるかrootユーザーに切り替えてください"
    exit 1
fi

# 複数指定は弾く
if [ $# -ne 1 ]; then
    echo "指定された引数は$#個です。" 1>&2
    echo "インストールするアーキテクチャを入力してください" 1>&2
    exit 1
fi

# ここからいろいろ入れる
if [[ $1 = "arm64" ]]; then # ARM64いれる
    echo "arm64"
    sudo apt update
    sudo apt upgrade -y
    sudo apt-get install ca-certificates curl gnupg lsb-release -y
    # repo
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

    # install compose
    sudo curl -L "${DOCKER_COMPOSE_ARM64_URL}" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose -v
    sudo docker -v
    exit 0
fi

if [[ $1 = "amd64" ]]; then # AMD64いれる
    echo "amd64"
    sudo apt update
    sudo apt upgrade -y
    sudo apt-get install ca-certificates curl gnupg lsb-release -y
    # repo
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

    # install compose
    sudo curl -L "${DOCKER_COMPOSE_AMD64_URL}" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose -v
    sudo docker -v
    exit 0
fi

if [[ $1 = "armv6" ]]; then # armv6いれる
    echo "armv6"
    sudo apt-get update
    sudo apt upgrade -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    docker -v

    # install compose
    sudo curl -L "${DOCKER_COMPOSE_ARMV6_URL}" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose -v
    sudo docker -v
    exit 0
fi

if [[ $1 = "armv7" ]]; then # armv7いれる
    echo "armv7"
    sudo apt-get update
    sudo apt upgrade -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y

    # install compose
    sudo curl -L "${DOCKER_COMPOSE_ARMV7_URL}" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose -v
    sudo docker -v
    exit 0
fi

echo "アーキテクチャが不明です"