#!/bin/bash

# ------ Get OS architecture -------
# 32bit(Intel) -> i686
# 64bit(Intel) -> x86_64
# 64bit(AMD)   -> arm64
get_arch() {
	echo $(uname -m)
}

# ------ Get OS -------
get_os() {
	if [ "$(uname)" == 'Darwin' ]; then
		OS='Mac'
	elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
		OS='Linux'
	elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
		OS='Cygwin'
	else
		OS=''
	fi
	echo $OS
}

# ------ If linux, get distribution name -----
get_distro() {
	if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
		# Check Ubuntu or Debian
		if [ -e /etc/lsb-release ]; then
			# Ubuntu
			distri_name="ubuntu"
		else
			# Debian
			distri_name="debian"
		fi
	elif [ -e /etc/arch-release ]; then
		# Arch Linux
		distri_name="arch"
	elif [ -e /etc/fedora-release ]; then
		# Fedra
		distri_name="fedora"
	else
		# Other
		distri_name="unkown"
	fi
	echo $distri_name
}

# Get distribution and bit
get_os_info() {
	echo $(get_arch) $(get_os) $(get_distro)
}

linux_prepare() {
	useradd -m -G wheel -s /bin/bash syamaguc
	echo 'syamaguc ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
	echo 'en_US.UTF-8 UTF-8' >/etc/locale.gen
	locale-gen
	echo 'LANG=en_US.UTF-8' >/etc/locale.conf
	ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
}

declare -a info=($(get_os_info))

case ${info[0]} in
"x86_64")
	if [[ ${info[1]} == "Linux" ]]; then
		if [[ ${info[2]} == "arch" ]]; then
			echo "start ${info[0]} ${info[1]} ${info[2]} setting..."
			linux_prepare
			pacman -Syu
			pacman -S make stow
			#bash script/setup-arch.sh
		elif [[ ${info[2]} == "Ubuntu" ]]; then
			echo "start ${info[0]} ${info[1]} ${info[2]} setting..."
			linux_prepare
			sudo apt-get update
			sudo apt-get install make stow
			#bash script/setup-ubuntu.sh
		elif [[ ${info[1]} == "Mac" ]]; then
			echo "Noe Implemented"
		fi
	fi
	;;
"arm64")
	if [[ ${info[1]} == "Mac" ]]; then
		echo "start ${info[0]} ${info[1]} ${info[2]} setting..."
		whoami
		brew update
		brew install make stow
		#bash script/setup-mac-arm64.sh
	elif [[ ${info[1]} == "" ]]; then
		echo "Noe Implemented"
	else
		echo "Noe Implemented"
	fi
	;;
*)
	echo "sorry,32bits is unsupported"
	;;
esac
