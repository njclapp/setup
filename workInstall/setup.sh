#!/bin/bash
# This script was written for use on a Macbook Pro(2013) running ubuntu 16.04.3LTS

# VARIABLES
PACKAGES='htop uprecords-cgi nload tcptrack unity-tweak-tool vim git rdesktop fping firmware-b43-installer sl tig'
THEME='vivacious-colors flatabulous-theme'

# Check if user is root
if ! whoami | grep -q root; then
  echo "Please restart this script as root"
  exit 1
else
  continue
fi

# Vivacious
add-apt-repository ppa:ravefinity-project/ppa -y

# Flatabulous
add-apt-repository ppa:noobslab/themes -y

# Atom
add-apt-repository ppa:webupd8team/atom -y

# Update
apt-get update && apt-get upgrade -y
apt-get dist-upgrade -y

# Install software and themes
apt-get install $PACKAGES -y
apt-get install $THEME -y


# Gets background pictures from imgur repo and sets default
wget http://imgur.com/sApPRDp.jpg http://imgur.com/b0gj8dw.jpg http://imgur.com/QbEzKgO.jpg http://imgur.com/XzIdxBS.jpg http://imgur.com/GUe3mvm.jpg
mv *.jpg /home/nate/Pictures
cd /home/nate/Pictures
cp -f XzIdxBS.jpg /usr/share/backgrounds/warty-final-ubuntu.png
