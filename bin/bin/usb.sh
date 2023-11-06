#!/bin/bash

if [ "$1" == "mount" ]; then
	sudo mkdir -p /mnt/usb
	sudo mount /dev/disk/by-uuid/5FD7-2391 /mnt/usb -o umask=000
fi

if [ "$1" == "remove" ]; then
	sudo umount /mnt/usb
fi
