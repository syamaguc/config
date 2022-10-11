#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: ./ssh.sh <name> <password> " 1>&2
	exit 1
fi

ssh-keygen -t rsa -b 4096 -C "" -f ~/.ssh/"$1".id_rsa -N "$2"
chmod 600 ~/.ssh/"$1".id_rsa
chmod 644 ~/.ssh/"$1".id_rsa.pub

cat >> ~/.ssh/config <<EOF
Host $1
  HostName github.com.$1
  User git
  Port 22
  IdentityFile ~/.ssh/$1.id_rsa
  TCPKeepAlive yes
  IdentitiesOnly yes
EOF
