#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt install --no-install-recommends -y \
     xorg xdm qiv policykit-1 \
     xmonad libghc-xmonad-contrib-dev xmobar \
     dmenu compton \
     xscreensaver feh \
     network-manager-gnome fdpowermon stalonetray \
     rxvt-unicode-256color neofetch \
     ttf-ubuntu-font-family \
     vim vifm htop firefox-esr  \
     rsync patch make emacs \
     gimp inkscape

sudo mkdir -p /usr/lib/X11/background
mkdir -p $HOME/.config
mkdir -p $HOME/data
mkdir -p $HOME/.config/systemd/user

ln -s $HOME/iOTA360_debian_xmonad/xmobar/ $HOME/.config/xmobar
ln -s $HOME/iOTA360_debian_xmonad/xmonad/ $HOME/.xmonad
ln -s $HOME/iOTA360_debian_xmonad/xscreensaver/xscreensaver $HOME/.xscreensaver
ln -s $HOME/iOTA360_debian_xmonad/xresources/Xresources $HOME/.Xresources
ln -s $HOME/iOTA360_debian_xmonad/xsessionrc/xsessionrc $HOME/.xsessionrc
ln -s $HOME/iOTA360_debian_xmonad/stalonetray/stalonetrayrc $HOME/.stalonetrayrc
sudo ln -sf $HOME/iOTA360_debian_xmonad/xdm/Xsetup /etc/X11/xdm/Xsetup
sudo ln -sf $HOME/iOTA360_debian_xmonad/xdm/Xresources /etc/X11/xdm/Xresources
sudo ln -sf $HOME/iOTA360_debian_xmonad/xdm/xdm_login.png /usr/lib/X11/background/xdm_login.png

cd st-0.8.4
sudo make clean install
cd ..

cd grub
sudo ./modify_grub.sh
cd ..

echo "PS1='\n\[\e[1m\]\[\e[38;2;211;54;130m\]\w\n\[\e[38;2;42;161;152m\]>>> \[\e[0m\]'" >> $HOME/.bashrc
echo "neofetch" >> $HOME/.bashrc

git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.emacs.d
$HOME/.emacs.d/bin/doom install
ln -s $HOME/iOTA360_debian_xmonad/doom_emacs/emacs.service $HOME/.config/systemd/user/emacs.service
systemctl enable --user emacs
systemctl start --user emacs
sudo ln -s $HOME/iOTA360_debian_xmonad/doom_emacs/doom.sh /usr/local/bin/doom.sh
sudo chmod +x /usr/local/bin/doom.sh
