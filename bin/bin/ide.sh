#!/bin/bash

# set tmux panes for ide

if [ "$#" -eq 0 ]; then
	tmux split-window -v
	tmux split-window -h
	tmux resize-pane -D 15
	tmux select-pane -t 1
else
	case $1 in
	1)
		tmux split-window -v
		tmux resize-pane -D 15
		tmux select-pane -D
		clear
		;;
	2)
		tmux split-window -h
		tmux split-window -v
		tmux resize-pane -D 15
		tmux select-pane -t 1
		tmux split-window -v
		tmux select-pane -t 1
		clear
		;;
	42)
		cd ~/Dev/42
		tmux split-window -v
		tmux split-window -h
		tmux resize-pane -D 15
		tmux select-pane -t 1
		clear
		;;
	*)
		echo "Usage: ide [1 2 42]\n"
		;;
	esac
fi
