#!/bin/bash

# あなたのExchangeRate-APIのAPIキーをここに設定
API_KEY="92f486e170329faec0ac8db2"

# ExchangeRate-APIのURL
URL="https://v6.exchangerate-api.com/v6/${API_KEY}/latest/USD"

# curlを使ってデータを取得し、jqでJPYレートを抽出
RATE=$(curl -s $URL | jq '.conversion_rates.JPY')

echo "$RATE"
