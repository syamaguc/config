#!/bin/sh
# Some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
# Disable ctrl-s to freeze terminal.
stty stop undef
zle_highlight=('paste:none')

# Beeping is annoying
unsetopt BEEP

# History options
setopt hist_ignore_all_dups
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history

# Colors
autoload -Uz colors && colors
