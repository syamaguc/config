#!/bin/sh
# --------------------------
# zsh
# --------------------------
alias zsh='source $ZDOTDIR/.zshrc'
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# --------------------------
# General
# --------------------------
alias path='echo $PATH | sed -e "s/:/\n/g"'
alias ll='ls -alF'
alias la='ls -la'
alias l='ls -CF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias df='df -h'
alias less='less -NM'


# --------------------------
# tmux
# --------------------------
alias tls='tmux ls'
alias tkill='tmux kill-session -t'
alias ta='tmux a -t'
alias tnew='tmux new -s'
alias ide='bash $HOME/bin/ide.sh'

# --------------------------
# Grep
# --------------------------
# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# --------------------------
# Moving
# --------------------------
alias ..='cd ..'
alias ...='cd ../../'
alias back='cd $(git rev-parse --show-toplevel)'


# --------------------------
# git
# --------------------------
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gca='git commit -A'
alias gcam='git commit --amend --no-edit'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gt='git tree'
alias gri='git rm -r --cached .; git add -A ; git commit -m "🧹 reflect .gitignore" '
alias gls='git log --stat'
alias glo='git log --oneline'
alias glp='git log -p'
alias glog="git log --date=short --pretty=format:'%Cgreen%h %cd %Cblue%cn%x09%Creset%s' | tail -1 && echo '' && git status -s -b"
ghq-update() { ghq list | ghq get --update --parallel; }

# --------------------------
# Docker
# --------------------------
dstop() { docker stop $(docker ps -a -q); }
drm() { docker rm -f $(docker ps -aq); }
drmi() { docker rmi -f $(docker images -aq); }
dup() { docker-compose up -d; }
dupr() { docker-compose restart; }
ddown() { docker-compose down; }
dclean() { docker system prune -a --volumes; docker builder prune; }
alias dl="docker ps -l -q"

# --------------------------
# C/C++
# --------------------------

# alias gccw='gcc -Wall -Werror -Wextra'
alias cl='clang++ -Wall -Werror -Wextra'
alias leaks='valgrind --leak-check=full'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# --------------------------
# memory
# --------------------------
# get top process eating memory
alias psmem='ps -auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps -auxf | sort -nr -k 3 | head -5'


# --------------------------
# find file
# --------------------------

fim() { nvim $(fzf-tmux --height 40% --reverse --border --preview 'bat --color="always" {}'); }

# --------------------------
# editor
# --------------------------
function editor() {
    if command -v nvim > /dev/null; then
        nvim "$@"
    elif command -v vim > /dev/null; then
        vim "$@"
    else
        vi "$@"
    fi
}

# --------------------------
# Architecture specific
# --------------------------

case "$(uname -s)" in

Darwin)
	alias copy='pbcopy'
	alias paste='pbpaste'
	alias ls='ls -G'
	alias vim='editor'
	;;

Linux)
	alias ls='ls --color=auto'
	alias vi='/usr/bin/vim'
	alias vim='editor'
	# get fastest mirrors

	alias mirror="sudo reflector --country Japan --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
	# For when keys break
	# alias archlinx-fix-keys="sudo pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman-key --refresh-keys"

	# systemd
	alias systemctl-list="systemctl list-unit-files --state=enabled"

	# output pacman packages
	alias pacman-list="pacman -Qqen"

	# output paru packages
  alias paru-list="paru -Qqem"
	# output yay packages
	alias yay-list="pacman -Qqem"

	# cliip board
	alias copy='xclip -selection clipboard'
	alias paste='xclip -selection clipboard -o'

  # screenshot
  alias scrot='scrot -s ~/Pictures/Screenshot/%b%d-%H%M%S.png'
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*) ;;

*) ;;

esac
