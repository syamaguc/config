COMMON = git zsh nvim
ADDITIONAL = lazygit tmux alacritty ranger mise bin
UBUNTU = x_ubuntu regolith3 libskk
ARCH_LINUX = x_arch i3 i3blocks picom rofi conky libskk dunst
MAC_OS = yabai skhd spacebar

fclean:
	@stow -Dv */


rename:
	python3 ./bin/bin/random_rename.py


link:
	$(eval UNAME_S := $(shell uname -s))
	$(eval UNAME_M := $(shell uname -m))
	$(eval DISTRO := $(if $(shell grep -s 'ID=' /etc/os-release),$(shell . /etc/os-release; echo $$ID),unknown))
	$(eval HOSTNAME := $(shell hostname))
	
	@echo "OS: $(UNAME_S)"
	@echo "Architecture: $(UNAME_M)"
	@echo "Distro: $(DISTRO)"
	@echo "Hostname: $(HOSTNAME)"
	
	# Symbolic link
	@if [ "$(UNAME_S)" = "Linux" ]; then \
		if [ "$(DISTRO)" = "ubuntu" ]; then \
			stow -v $(COMMON) $(ADDITIONAL) $(UBUNTU);\
		elif [ "$(DISTRO)" = "arch" ]; then \
			stow -v $(COMMON) $(ADDITIONAL) $(ARCH_LINUX);\
		else \
			echo "Not supported";\
		fi; \
	elif [ "$(UNAME_S)" = "Darwin" ]; then \
		stow -v $(COMMON) $(ADDITIONAL) $(MAC_OS);\
	else \
		echo "Not supported";\
	fi \
	# Xmodmap
	@if [ "$(HOSTNAME)" = "Thinkpad-E14-Gen3" ]; then \
		stow -v thinkpad; \
	fi

.PHONY: fclean link
