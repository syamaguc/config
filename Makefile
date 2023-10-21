COMMON = git zsh vim
LOCAL_COMMON = nvim tmux alacritty bin
LINUX = x i3 i3blocks picom rofi conky libskk
MAC_OS = yabai skhd

archlinux: local
	@stow -v $(LINUX)

mac: local
	@stow -v $(MAC_OS)

local: server
	@stow -v $(LOCAL_COMMON)

server:
	@stow -v $(COMMON)


clean:
	@stow -Dv */
