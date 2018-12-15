#!/bin/bash
# This script was written for use on Ubuntu 18.04LTS

# VARIABLES
USER=''
BASIC_PACKAGES='vim htop git lm-sensors atom unity-tweak-tool vlc steam chromium-browser putty sl tig uprecords-cgi qemu-kvm libvirt-bin bridge-utils virt-manager gnome-multi-writer minecraft-installer neofetch rename'
SYSADMIN_PACKAGES='nmap fping rdesktop tcptrack nload'
DISCORD_VERSION='0.0.5'

# Check if user is root
if ! whoami | grep -q root; then
  echo "Please restart this script as root"
  exit 1
else
  continue
fi

# Initial Update
apt-get update && sudo apt-get upgrade -y
apt-get dist-upgrade -y

# Basic linux stuff
apt-get install $BASIC_PACKAGES -y

# Sysadmin related packages
apt-get install $SYSADMIN_PACKAGES -y

# Move dotfiles
mv .bashrc /home/$USER/; chown $USER:$USER /home/$USER/.bashrc
mv .vimrc /home/$USER/; chown $USER:$USER /home/$USER/.vimrc

# Create picture directories
mkdir /home/$USER/Pictures/sun_positionals /home/$USER/Pictures/wallpapers /home/$USER/Pictures/light /home/$USER/Pictures/dark

# Get sun positionals
cd /home/$USER/Pictures/sun_positionals
wget -4 https://imgur.com/a/VN0a0Vi/zip && unzip zip && rm -rf zip

# Get wallpapers
cd /home/$USER/Pictures/wallpapers
wget -4 https://imgur.com/a/29jWnHn/zip && unzip zip && rm -rf zip
