export ZDOTDIR=$HOME/.config/zsh

typeset -U path
path=(
  $HOME/.local/share/mise/shims(N-/)
  $HOME/.local/bin(N-/)
  $HOME/bin(N-/)
  $path
)

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
<<<<<<< HEAD

=======
>>>>>>> 2a87a36753e775238bf9b1ec4dfd66da1019cb47
. "$HOME/.cargo/env"
