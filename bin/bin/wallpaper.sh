#!/bin/bash

# 選択肢のリストを定義
options=("nature" "minimal" "starwars" "weeb")

# 選択肢を表示
echo "Select an option:"

# 選択肢を順番に表示
select opt in "${options[@]}"; do
	echo "Your choice is $opt"

	WALLPAPER_DIR="$HOME/wallpaper/$opt/"

	#WALLPAPER_DIR="$HOME/wallpaper/nature"

	# 指定したディレクトリからランダムにファイルを1つ選択
	SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

	echo $SELECTED_WALLPAPER
	case "$(uname -s)" in
	Darwin)
		osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$SELECTED_WALLPAPER\""
		;;

	Linux)
		cat <<EOF >$HOME/config/regolith3/.config/regolith3/wallpaper.Xresources
regolith.lockscreen.wallpaper.file: $SELECTED_WALLPAPER
regolith.wallpaper.file:            $SELECTED_WALLPAPER
EOF
		regolith-look refresh
		;;

	CYGWIN* | MINGW32* | MSYS* | MINGW*) ;;

	*) ;;

	esac
done
