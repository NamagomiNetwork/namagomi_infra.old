CF_TOKEN_ID=${CF_TOKEN_ID}
CF_TOKEN_SECRET=${CF_TOKEN_SECRET}

screen -UAmdS lobby cloudflared access tcp --hostname lobby-tcp-cloudflared.nabr2730.com --url localhost:30000 --id ${CF_TOKEN_ID} --secret ${CF_TOKEN_SECRET}
screen -r lobby