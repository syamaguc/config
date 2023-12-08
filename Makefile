COMMON = git zsh vim
LOCAL_COMMON = gh lazygit nvim tmux alacritty bin ranger
LINUX = x i3 i3blocks picom rofi conky libskk dunst
MAC_OS = yabai skhd

archlinux: local
	@stow -v $(LINUX)

mac: local aquaskk
	@stow -v $(MAC_OS)

local: server
	@stow -v $(LOCAL_COMMON)

aquaskk:
	@rm -rf ~/Library/Application\ Support/AquaSKK/keymap.conf
	@cp /Library/Input\ Methods/AquaSKK.app/Contents/Resources/keymap.conf ~/Library/Application\ Support/AquaSKK/keymap.conf
	@echo "StickyKey  ;" >> ~/Library/Application\ Support/AquaSKK/keymap.conf

server:
	@stow -v $(COMMON)



setup-mac:
	brew update

setup-archlinux: setup-linux
	pacman -Syu --noconfirm
	pacman -S sudo --noconfirm

setup-ubuntu: setup-linux
	apt-get update

setup-linux:
	useradd -m -G wheel -s /bin/bash syamaguc
	echo 'syamaguc ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
	echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen 
	locale-gen 
	echo 'LANG=en_US.UTF-8' > /etc/locale.conf 
	ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime 
	hwclock --systohc 

clean:
	@stow -Dv */
