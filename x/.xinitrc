#!/bin/sh

# start up program in .xprofile
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.xprofile ] && source ~/.xprofile
[ -f ~/.profile ] && source ~/.profile

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi
