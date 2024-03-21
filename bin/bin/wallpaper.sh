#!/bin/bash

# 壁紙に設定する画像が格納されているディレクトリのパスを指定
WALLPAPER_DIR="$HOME/config/wallpaper"

# 指定したディレクトリからランダムにファイルを1つ選択
SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

case "$(uname -s)" in
Darwin)
	osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$SELECTED_WALLPAPER\""
	;;

Linux) ;;

CYGWIN* | MINGW32* | MSYS* | MINGW*) ;;

*) ;;

esac
