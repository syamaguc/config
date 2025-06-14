# NOTE: 
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export ZDOTDIR=$HOME/.config/zsh

#typeset -U path
#path=(
#  $HOME/.local/share/mise/shims(N-/)
#  $HOME/.local/bin(N-/)
#  $HOME/bin(N-/)
#  $HOME/snap/bin(N-/)
#  $HOME/.yarn/bin(N-/)
#  /snap/bin(N-/)
#  $path
#)

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

[ -f ~/.cargo/env ] && . "$HOME/.cargo/env"

eval "$(ssh-agent -s)"
