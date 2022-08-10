#!/bin/bash

BASE=(\
      # basic item
      stow tmux git man htop zsh \
      # terminal
      alacritty \
      # for japanese
      fcitx fcitx-mozc fcitx-configtool \
      # i3 & important apps
      i3 feh rofi ranger conky picom \
      # lightdm
      lightdm lightdm-webkit2-greeter lightdm-gtk-greeter \
      # network
      net-tools networkmanager network-manager-applet \
      # Misc
      unzip wget nautilus xorg xsel jq alsa-utils neofetch xdg-user-dirs \
      # for language
      npm rust go \
      # for python
      python-pip \
      # for vim
      ripgrep fzf \
      # fonts
      otf-ipafont noto-fonts noto-fonts-emoji \
      # sound
      pulseaudio pulseaudio-alsa pavucontrol \
      )

AUR=(\
      google-chrome \
      ttf-ricity-diminished \
      autotiling \
      lightdm-webkit2-theme-glorious \
      )

function lightdm-setting () {
      # Set default lightdm greeter to lightdm-webkit2-greeter
      sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
      # Set default lightdm-webkit2-greeter theme to Glorious
      sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = glorious #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
      sudo sed -i 's/^debug_mode\s*=\s*\(.*\)/debug_mode = true #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
      # Fix failed to start lightdm @AMD processor
      sudo sed -i 's/^\(#?logind\)-check-graphical\s*=\s*\(.*\)/logind-check-graphical = true #\1/g' /etc/lightdm/lightdm.conf
}

function tmux-setting () {
      if [ -f $HOME/.tmux/plugins/tpm ]; then
            ;
      else
            git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
      fi
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
  yay -Sy --noconfirm --needed $app
done

lightdm-setting
tmux-setting

echo "Finish, all done.\n"
