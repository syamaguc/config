export ZDOTDIR=$HOME/.config/zsh
echo "Hello, $USER."

# OS specific settings

case "$(uname -s)" in

Darwin)
  eval "$(/opt/homebrew/bin/brew shellenv)"
	;;

Linux)
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*) ;;

*) ;;

esac
