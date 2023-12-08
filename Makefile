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


detect:
	$(eval UNAME_S := $(shell uname -s))
	$(eval UNAME_M := $(shell uname -m))
	$(eval DISTRO := $(if $(shell grep -s 'ID=' /etc/os-release),$(shell . /etc/os-release; echo $$ID),unknown))
	
	@echo "OS: $(UNAME_S)"
	@echo "Architecture: $(UNAME_M)"
	@echo "Distro: $(DISTRO)"
	
	# LINUX
	@if [ "$(UNAME_S)" = "Linux" ]; then \
		# Ubuntu
		if [ "$(DISTRO)" = "ubuntu" ]; then \
			echo "Running Ubuntu specific tasks"; \
			cat script/package.apt.txt | xargs sudo apt-get install -y;\
			stow -v $(COMMON) $(LOCAL_COMMON) $(LINUX);\
		# Arch Linux
		elif [ "$(DISTRO)" = "arch" ]; then \
			echo "Running Arch Linux specific tasks"; \
			cat script/package.pacman.txt | xargs pacman -S --noconfirm;\
			stow -v $(COMMON) $(LOCAL_COMMON) $(LINUX);\
		else \
			echo "Unsupported Linux distro: $(DISTRO)"; \
		fi; \
	# MAX OS
	elif [ "$(UNAME_S)" = "Darwin" ]; then \
		# Apple Silicon
		if [ "$(UNAME_M)" = "arm64" ]; then \
			echo "Running tasks for macOS on ARM64"; \
		# X86_64
		elif [ "$(UNAME_M)" = "x86_64" ]; then \
			echo "Running tasks for macOS on x86_64"; \
			brew bundle --file=script/Brewfile; \
			stow -v $(COMMON) $(LOCAL_COMMON) $(MAC_OS);\
		else \
			echo "Unsupported macOS architecture"; \
		fi; \
	else \
		echo "Unsupported OS"; \
	fi
