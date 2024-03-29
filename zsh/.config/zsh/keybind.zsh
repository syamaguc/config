autoload history-search-end
# zle
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Key-bindings
bindkey -s '^o' 'ranger^M'
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down

bindkey "^?" backward-delete-char
