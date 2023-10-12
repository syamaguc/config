BASE=(
	# basic
	stow tmux gnu-sed nvim
	# terminal
	alacritty
)

function brew-install() {
	printf "Install basics ...\n"

	for app in "${BASE[@]}"; do
		brew install "$app"
	done
}

function font-install() {
	bew tap homebrew/cask-fonts
	brew install font-ricty-diminished
	brew install font-hack-nerd-font

}

function fzf-install() {
	brew install fzf
	# To install useful key bindings and fuzzy completion:
	$(brew --prefix)/opt/fzf/install

}

brew-install
font-install
fzf-install
