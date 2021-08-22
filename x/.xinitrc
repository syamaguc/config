#!/bin/sh

# start up program in .xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
