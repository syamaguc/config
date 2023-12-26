source $ZDOTDIR/zshrc
eval "$(rtx activate zsh)"

# tmux auto start
tmux has-session &>/dev/null
if [[ $? = 0 && ! -n $TMUX ]]; then
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
