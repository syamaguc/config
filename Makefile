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
