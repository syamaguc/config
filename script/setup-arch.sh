#!/bin/bash

BASE=(\
      # basic item
      stow tmux git man htop zsh \
      # terminal
      alacritty \
      # for japanese
      fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-nord \
      # i3 & important apps
      i3 i3blocks feh rofi ranger conky picom \
      # lightdm
      lightdm lightdm-gtk-greeter \
      # network
      net-tools networkmanager network-manager-applet \
      # Misc
      unzip wget nautilus xorg xsel jq alsa-utils neofetch xdg-user-dirs \
      # for language
      npm yarn rust go \
      # for python
      python-pip \
      # for vim
      neovim ripgrep fzf shellcheck \
      # fonts
      otf-ipafont noto-fonts noto-fonts-emoji \
      # sound
      pulseaudio pulseaudio-alsa pavucontrol \
      # apps
      discord \
      )

AUR=(\
      google-chrome \
      dropbox \
      ttf-ricty-diminished \
      autotiling \
      slack-desktop \
      snapd \
      )

# TODO:
function lightdm-setting () {
      # Fix failed to start lightdm @AMD processor
      sudo sed -i 's/^\(#?logind\)-check-graphical\s*=\s*\(.*\)/logind-check-graphical = true #\1/g' /etc/lightdm/lightdm.conf
      systemctl enable lightdm
      systemctl start lightdm
}

function tmux-setting () {
      if [ -f $HOME/.tmux/plugins/tpm ]; then
            echo "plugin already exist";
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
chsh -s /bin/zsh
systemctl start NetworkManager

echo "Finish, all done.\n"
