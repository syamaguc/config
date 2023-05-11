source $ZDOTDIR/zshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/syamaguc/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/home/syamaguc/.local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/syamaguc/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/syamaguc/.local/google-cloud-sdk/completion.zsh.inc'; fi
