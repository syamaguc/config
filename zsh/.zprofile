# enable Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use my custom zsh file
# if you want to use ohmyzsh, comment out and
# cp ./oh_my_zsh/template/template .zshrc
export ZDOTDIR=$HOME/.config/zsh

# tmux auto start
tmux has-session &>/dev/null
if [ $? = 0 ]; then
    echo "There are session"
    echo "---------------------------------"
    tmux ls
    echo "---------------------------------"
    echo "Do you attach? (y/n)"
    read ans
    case $ans in
        "")
            tmux a
            ;;
        "y")
            tmux a
            ;;
        "n")
            ;;
        *)
            ;;
    esac
fi
