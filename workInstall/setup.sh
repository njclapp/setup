#!/bin/bash
# This script was written for use on ubuntu 16.04.2LTS

# Check if user is root
if ! whoami | grep -q root; then
  echo "Please restart this script as root"
  exit 1
else
  continue
fi

# Vivacious
add-apt-repository ppa:ravefinity-project/ppa

#Flatabulous
add-apt-repository ppa:noobslab/themes

# Update
apt-get update
apt-get upgrade -y

# Install software and themes
apt-get -y install htop uprecords-cgi nload tcptrack unity-tweak-tool vim
apt-get -y install vivacious-colors flatabulous-theme

# Gets and installs the latest version of atom
wget https://atom.io/download/deb -O atom.deb
dpkg -i atom.deb

# Gets background pictures from imgur repo and sets default
wget http://imgur.com/sApPRDp.jpg http://imgur.com/b0gj8dw.jpg http://imgur.com/QbEzKgO.jpg http://imgur.com/XzIdxBS.jpg http://imgur.com/GUe3mvm.jpg
mv *.jpg /home/nate/Pictures
cd /home/nate/Pictures
cp -f XzIdxBS.jpg /usr/share/backgrounds/warty-final-ubuntu.png
