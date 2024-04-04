#! /bin/bash

if [ $# -eq 1 ]; then
	ssh-keygen -t ed25519 -C "$@" -f $HOME/.ssh/"$@"_ed25519
else
	ssh-keygen -t ed25519 -C "$(hostname)" -f $HOME/.ssh/$(hostname)_ed25519
fi
