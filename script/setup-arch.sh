#!/bin/bash

welcome() {
  echo "Welcome, to Myscript, this script will bootstrap Arch linux with programs and development tools to increase your productivity."
  echo "For this installer to work you will need to have an active internet connection and allow this program to run as root."
}

username() {
  echo -n "Enter new username: "
  read username
}

install_basics() {
  sudo pacman --noconfirm --needed -Sy $(< $HOME/config/packages/base.list)
}

install_aur_helper() {
  mkdir -p $HOME/tmp
  cd $HOME/tmp
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg --noconfirm -si 
  cd -
  sudo rm -rf $HOME/tmp/yay-bin
}

install_aur_packages() {
  sudo yay --noconfirm --needed -Sy $(< $HOME/config/packages/aur.list)
}

install_fonts() {
  # do you want all the nerdfonts? This is about 2GB of data
  yay --noconfirm --needed -Sy nerd-fonts-jetbrains-mono
}

start_network_service() {
  systemctl start NetworkManager
  systemctl enable NetworkManager
}

start_display_manager_service() {
  systemctl enable lightdm
}

# reuse this function
install_extras() {
  while true; do
    echo "Do you want to install extras?"
    cat $HOME/config/packages/extra.list
    echo "(y) install extras"
    echo "(n) don't install extras"
    read -p "> " ync
      case $ync in
          [Yy]* ) sudo yay --noconfirm --needed -Sy $(< $HOME/config/packages/extra.list); break;;
          [Nn]* ) echo "Not installing extras"; break;;
          * ) echo " ";;
      esac
  done
}


# install_data_science_package() {
#   # ask first
#   sudo pacman -S $(< ./packages/data_science.list)
# }

# install_web_dev_package() {
#   # ask first
#   sudo pacman -S $(< ./packages/web_dev.list)
# }

# install_normie_package() {
#   # ask first
#   sudo pacman -S $(< ./packages/normie.list)
# }

# install_nvcode() {

# }

welcome
username
install_basics
install_aur_helper
install_aur_packages
install_extras
start_network_service
start_display_manager_service
