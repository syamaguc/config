COMMON = git zsh vim
LOCAL_COMMON = gh lazygit nvim tmux alacritty bin ranger rtx
LINUX = x i3 i3blocks picom rofi conky libskk dunst
MAC_OS = yabai skhd

archlinux: local
	@stow -v $(LINUX)

mac: local aquaskk
	@stow -v $(MAC_OS)

local: server
	@stow -v $(LOCAL_COMMON)



server:
	@stow -v $(COMMON)

clean:
	@stow -Dv */

link:
	$(eval UNAME_S := $(shell uname -s))
	$(eval UNAME_M := $(shell uname -m))
	$(eval DISTRO := $(if $(shell grep -s 'ID=' /etc/os-release),$(shell . /etc/os-release; echo $$ID),unknown))
	
	@echo "OS: $(UNAME_S)"
	@echo "Architecture: $(UNAME_M)"
	@echo "Distro: $(DISTRO)"
	
	@if [ "$(UNAME_S)" = "Linux" ]; then \
		if [ "$(DISTRO)" = "ubuntu" ]; then \
			stow -v $(COMMON) $(LOCAL_COMMON) $(LINUX);\
		elif [ "$(DISTRO)" = "arch" ]; then \
			stow -v $(COMMON) $(LOCAL_COMMON) $(LINUX);\
		else \
			echo "Not supported";\
		fi; \
	elif [ "$(UNAME_S)" = "Darwin" ]; then \
		if [ "$(UNAME_M)" = "arm64" ]; then \
			stow -v $(COMMON) $(LOCAL_COMMON) $(MAC_OS);\
		elif [ "$(UNAME_M)" = "x86_64" ]; then \
			stow -v $(COMMON) $(LOCAL_COMMON) $(MAC_OS);\
		else \
			echo "Not supported";\
		fi; \
	else \
		echo "Not supported";\
	fi

.PHONY: archlinux mac local server clean link
