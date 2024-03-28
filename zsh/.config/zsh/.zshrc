##############################
#    Load setting files
##############################
source $ZDOTDIR/functions.zsh

zsh_add_file "opt.zsh"
zsh_add_file "exports.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "plugin.zsh"
zsh_add_file "prompt.zsh"
zsh_add_file "fzf.zsh"
zsh_add_file "completions.zsh"
zsh_add_file "vim.zsh"
zsh_add_file "tmux.zsh"
zsh_add_file "keybind.zsh"

##############################
#   Tools insert path
##############################

# for mise
eval "$(~/.local/bin/mise activate zsh)"

# bun completions
[ -s "/Users/syamaguc/.bun/_bun" ] && source "/Users/syamaguc/.bun/_bun"


# fzf
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"

# pacman 
[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

# alacritty
fpath+=${ZDOTDIR:-~}/.zsh_functions
