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

clean:
	@stow -Dv */

ci:
	$(eval UNAME_S := $(shell uname -s))
	$(eval UNAME_M := $(shell uname -m))
	$(eval DISTRO := $(if $(shell grep -s 'ID=' /etc/os-release),$(shell . /etc/os-release; echo $$ID),unknown))
	
	@echo "OS: $(UNAME_S)"
	@echo "Architecture: $(UNAME_M)"
	@echo "Distro: $(DISTRO)"
	
	@if [ "$(UNAME_S)" = "Linux" ]; then \
		if [ "$(DISTRO)" = "ubuntu" ]; then \
			echo "Running Ubuntu specific tasks"; \
			cat script/package.apt.txt | xargs sudo apt-get install -y;\
			stow -v $(COMMON) $(LOCAL_COMMON) $(LINUX);\
		elif [ "$(DISTRO)" = "arch" ]; then \
			echo "Running Arch Linux specific tasks"; \
			cat script/package.pacman.txt | xargs pacman -S --noconfirm --needed;\
			stow -v $(COMMON) $(LOCAL_COMMON) $(LINUX);\
		else \
			echo "Unsupported Linux distro: $(DISTRO)"; \
		fi; \
	elif [ "$(UNAME_S)" = "Darwin" ]; then \
		if [ "$(UNAME_M)" = "arm64" ]; then \
			echo "Running tasks for macOS on ARM64"; \
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

.PHONY: archlinux mac local server clean ci
