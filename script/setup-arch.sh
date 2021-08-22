#!/bin/bash

BASE=(\
      # basic item
      stow git man htop zsh \
      # terminal
      alacritty \
      # for japanese
      fcitx fcitx-mozc fcitx-configtool \
      # i3 & important apps
      i3 feh rofi fzf ranger \
      # lightdm
      lightdm lightdm-webkit2-greeter \
      # network
      networkmanager network-manager-applet \
      # Misc
      unzip wget nautilus xorg xsel jq alsa-utils \
      # for language
      npm rust go
      )

AUR=(\
      google-chrome \
      lightdm-webkit2-theme-glorious \
      )

function lightdm-setting () {
      # Set default lightdm greeter to lightdm-webkit2-greeter
      sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
      # Set default lightdm-webkit2-greeter theme to Glorious
      sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = glorious #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
      sudo sed -i 's/^debug_mode\s*=\s*\(.*\)/debug_mode = true #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
}

echo "Install basics ...\n"

for app in ${BASE[@]}; do
  sudo pacman -Sy --noconfirm --needed $app
done

which yay >/dev/null 2>&1
case $? in
      0)
            ;;
      1)
            echo "Install yay ...\n"
            mkdir -p $HOME/tmp
            cd $HOME/tmp
            git clone https://aur.archlinux.org/yay-bin.git
            cd yay-bin
            makepkg --noconfirm -si
            cd -
            sudo rm -rf $HOME/tmp/yay-bin
            ;;
esac

echo "Install AUR packages ...\n"
for app in ${AUR[@]}; do
  sudo yay -Sy --noconfirm --needed $app
done

#lightdm-setting

echo "Finish, all done.\n"
