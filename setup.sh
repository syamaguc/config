APPS=(stow ag rg)

# Mac OS
if [ "$(uname)" == 'Darwin' ]; then
    brew update && brew upgrade && brew cleanup && brew autoremove
	for app in ${APPS[@]}; do
	  brew install $app
	  echo "install $app"
	done
    # install oh my zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Linux 
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # Ubuntu 
    sudo apt update && sudo apt upgrade
	if [ "$(expr substr $(cat /etc/*-release | grep "^NAME=") 7 6)" == 'Ubuntu' ]; then
		for app in ${APPS[@]}; do
		  sudo apt install $app
		  echo "install $app"
		done
	fi
else
	echo "I don't know this OS"
fi
