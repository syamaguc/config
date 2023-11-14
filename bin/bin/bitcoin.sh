#/bin/bash

# CoinGecko APIを使ってBitcoinの現在価格を取得
URL_US="https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
URL_JP="https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=jpy"

# curlを使ってデータを取得し、jqで価格情報を抽出
BTC_USD=$(curl -s $URL_US | jq '.bitcoin.usd')
BTC_JPY=$(curl -s $URL_JP | jq '.bitcoin.jpy')

echo "$BTC_USD usd  | $BTC_JPY jpy"
