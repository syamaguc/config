COMMON = git zsh nvim
ADDITIONAL = lazygit tmux alacritty ranger mise bin
UBUNTU = regolith3 libskk
ARCH_LINUX = x i3 i3blocks picom rofi conky libskk dunst
MAC_OS = yabai skhd sketchybar
	
KERNEL := $(shell uname -r)
UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)
HOSTNAME := $(shell hostname)
DISTRO := $(if $(shell grep -s 'ID=' /etc/os-release),$(shell . /etc/os-release; echo $$ID),unknown)

show:
	#######################
	#     Information     #
	#######################

	@echo "KERNEL: $(KERNEL)"
	@echo "OS: $(UNAME_S)"
	@echo "Architecture: $(UNAME_M)"
	@echo "Hostname: $(HOSTNAME)"
	@echo "Distro: $(DISTRO)"

install:
	#######################
	#   Install Packages  #
	#######################
	@if [ "$(UNAME_S)" = "Linux" ]; then \
		if [ "$(DISTRO)" = "ubuntu" ]; then \
			sudo xargs apt install -y < ./pkg/package.apt.txt; \
		elif [ "$(DISTRO)" = "arch" ]; then \
			sudo xargs pacman -Syu --noconfirm --needed < ./pkg/package.pacman.txt; \
		else \
			echo "Not supported";\
		fi; \
	elif [ "$(UNAME_S)" = "Darwin" ]; then \
		brew bundle --file=./pkg/Brewfile; \
	else \
		echo "Not supported";\
	fi

link: show
	#######################
	#    synbolic link    #
	#######################

	@if [ "$(UNAME_S)" = "Linux" ]; then \
		if [ "$(DISTRO)" = "ubuntu" ]; then \
			stow -v $(COMMON) $(ADDITIONAL) $(UBUNTU); \
		elif [ "$(DISTRO)" = "arch" ]; then \
			stow -v $(COMMON) $(ADDITIONAL) $(ARCH_LINUX); \
		else \
			echo "Not supported";\
		fi; \
	elif [ "$(UNAME_S)" = "Darwin" ]; then \
		stow -v $(COMMON) $(ADDITIONAL) $(MAC_OS); \
	else \
		echo "Not supported";\
	fi
	#######################
	#       keyboard      #
	#######################
	@if [ "$(HOSTNAME)" = "ThinkPad-E14-Gen3" ]; then \
		echo "remap Key for Thinkpad"; \
		stow -v thinkpad; \
	else \
		echo "Using HHKB"; \
	fi
	#######################
	#         WSL         #
	#######################
	@if echo "$(KERNEL)" | grep -q microsoft ; then \
		echo "WSL Setup..."; \
	fi

fclean:
	@stow -Dv */


.PHONY: fclean link show keyboard
