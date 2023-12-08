#!/bin/bash

# ------ Get OS architecture -------
# 32bit(Intel) -> i686
# 64bit(Intel) -> x86_64
# 64bit(AMD)   -> arm64
function get_arch() {
	echo $(uname -m)
}

# ------ Get OS -------
function get_os() {
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
function get_distro() {
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
function get_os_info() {
	echo $(get_arch) $(get_os) $(get_distro)
}

function linux_prepare() {
	useradd -m -G wheel -s /bin/bash syamaguc
	echo 'syamaguc ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
	echo 'en_US.UTF-8 UTF-8' >/etc/locale.gen
	locale-gen
	echo 'LANG=en_US.UTF-8' >/etc/locale.conf
	ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
}

function install_yay() {
	which yay >/dev/null 2>&1
	case $? in
	0) ;;

	1)
		echo "Install yay ..."
		mkdir -p "$HOME/tmp"
		cd "$HOME/tmp" || exit
		pacman -S git base-devel --noconfirm --needed
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si --noconfirm
		cd - || exit
		sudo rm -rf "$HOME/tmp/yay"
		;;
	esac
}

declare -a info=($(get_os_info))

case ${info[0]} in
"x86_64")
	if [[ ${info[1],,} == "linux" ]]; then
		if [[ ${info[2],,} == "arch" ]]; then
			echo "start ${info[0]} ${info[1]} ${info[2]} setting..."
			linux_prepare
			pacman -Syu --noconfirm
			pacman -S sudo make stow --noconfirm --needed
			install_yay
		elif [[ ${info[2],,} == "ubuntu" ]]; then
			echo "start ${info[0]} ${info[1]} ${info[2]} setting..."
			linux_prepare
			sudo apt-get update -y
			sudo apt-get install make stow -y
		else
			echo "Noe Implemented"
		fi
	elif [[ ${info[1],,} == "mac" ]]; then
		echo "start ${info[0]} ${info[1]} ${info[2]} setting..."
		whoami
		brew update
		brew install make stow
	else
		echo "Noe Implemented"
	fi
	;;
"arm64")
	if [[ ${info[1],,} == "mac" ]]; then
		echo "start ${info[0]} ${info[1]} ${info[2]} setting..."
		whoami
		brew update
		brew install make stow
		#bash script/setup-mac-arm64.sh
	else
		echo "Noe Implemented"
	fi
	;;
*)
	echo "sorry,32bits is unsupported"
	;;
esac
