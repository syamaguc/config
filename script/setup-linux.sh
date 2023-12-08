useradd -m -G wheel -s /bin/bash syamaguc
echo 'syamaguc ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
echo 'en_US.UTF-8 UTF-8' >/etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' >/etc/locale.conf
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc
