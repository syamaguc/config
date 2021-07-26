#!/usr/bin/env bash

# Dont link DS_Store files
find . -name ".DS_Store" | xargs rm -rf

# Default
PROGRAMS=(common git vim)
BACKUPS=(.bash_profile .bashrc .bash_logout .zshrc .ssh .tmux.conf .profile .config)

# OS specific
if [ "$(uname)" == 'Darwin' ]; then
	echo "Mac OS Setting"
	PROGRAMS+=(mac)
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	if [ "$(expr substr $(cat /etc/*-release | grep "^NAME=") 7 6)" == 'Ubuntu' ]; then
		echo "Ubuntu Setting"
		PROGRAMS+=(ubuntu)
	fi
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	echo "Windows Setting"
	PROGRAMS+=(windows)
else
	echo " I don't know this OS"
fi

# helper function
function backup_if_exists() {
    if [ -f $1 ];
    then
      mv $1 "$1.bk"
    fi
    if [ -d $1 ];
    then
      mv $1 "$1.bk"
    fi
}

# Clean up all symlinks
if [ "$1" == "clean" ]; then
    for program in ${PROGRAMS[@]}; do
      stow -vD $program
      echo "clean up $program"
    done
    echo "Clean up all"
    exit 0
fi

# execute
for backup in ${BACKUPS[@]}; do
  backup_if_exists ~/$backup
  echo "Backup $backup"
done

for program in ${PROGRAMS[@]}; do
  stow -v $program
  echo "Setting up $program"
done
