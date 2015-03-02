#!/bin/bash

# define pacman packages
pacman_packages="python2-pyopenssl"

# install pre-reqs
pacman -Sy --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# call aur packer script
source /root/packer.sh

# set permissions
chown -R nobody:users /opt/couchpotato
chmod -R 775 /opt/couchpotato

# cleanup	
pacman -Ru packer base-devel git --noconfirm
yes|pacman -Scc
userdel -r makepkg-user
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /root/*
rm -rf /tmp/*
