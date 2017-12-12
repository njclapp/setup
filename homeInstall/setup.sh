#!/bin/bash
# This script was written for use on ubuntu 16.04.3LTS

# VARIABLES
HOSTNAME=''
BASIC_PACKAGES='vim htop git lm-sensors atom unity-tweak-tool vlc steam chromium-browser putty sl tig uprecords-cgi'
SYSADMIN_PACKAGES='nmap fping rdesktop tcptrack nload'
THEME='ultra-flat-icons flatabulous-theme'

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

# Move backgrounds to pictures folder
cp Wallpapers/* /home/nate/Pictures
chmod 777 /home/nate/Pictures/*

# Add repos and update
add-apt-repository ppa:webupd8team/atom -y # Atom
add-apt-repository ppa:noobslab/themes -y # Themes
add-apt-repository ppa:noobslab/icons -y # Icons
apt-get update

# Basic linux stuff
apt-get install $BASIC_PACKAGES -y

# Sysadmin related packages
apt-get install $SYSADMIN_PACKAGES -y

# Themes/Icon packs
apt-get install $THEME -y

# Set up lm-sensors
sensors-detect

#set login screen/desktop background
cp Wallpapers/Wallpaper.png /usr/share/backgrounds/
cd /usr/share/backgrounds/
mv warty-final-ubuntu.png warty-final-ubuntu.bak
mv Wallpaper.png warty-final-ubuntu.png

/usr/bin/gsettings set org.gnome.desktop.interface gtk-theme 'Flatabulous'
/usr/bin/gsettings set org.gnome.desktop.wm.preferences theme 'Flatabulous'
/usr/bin/gsettings set org.gnome.desktop.interface icon-theme 'Ultra-Flat'
/usr/bin/gsettings set com.canonical.Unity.Launcher launcher-position Bottom

# Change hostname
hostn=$(cat /etc/hostname)
sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hosts
sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hostname


read -p "Setup has completed. Press any key to reboot."
reboot