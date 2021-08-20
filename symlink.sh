#!/usr/bin/sh

# Dont link DS_Store files
find . -name ".DS_Store" | xargs rm -rf

# Default
BACKUPS=(.config .bashrc .bash_logout .zshrc .vimrc .bash_profile .zprofile .profile .xprofile .Xresources .xinitrc .tmux.conf i3)

# helper function
function backup_if_exists() {
    if [ -f $1 ] && [ ! -L $1 ];
    then
      mv $1 "$1.bk"
    fi
    if [ -d $1 ] && [ ! -L $1 ];
    then
      mv $1 "$1.bk"
    fi
}

function backup_to_default() {
    if [ -f "$1.bk" ] && [ ! -L "$1.bk" ];
    then
      mv "$1.bk" $1
    fi
    if [ -d "$1.bk" ] && [ ! -L "$1.bk" ];
    then
      mv "$1.bk" $1
    fi
}

# Clean up all symlinks
if [ "$1" == "clean" ]; then
    declare -a SYMLINKS=(`ls -a1 | grep -v symlink.sh | grep -v setup.sh | grep -v "\."`)
    for link in ${SYMLINKS[@]}; do
	  stow -Dv $link
      echo "clean up $link"
    done
    for backup in ${BACKUPS[@]}; do
      backup_to_default ~/$backup
      echo "Reset $backup"
    done
else
    # backup & symlink
    for backup in ${BACKUPS[@]}; do
      backup_if_exists ~/$backup
      echo "Backup $backup"
    done
    for program in $@; do
      stow -v $program
      echo "Setting up $program"
    done
fi

