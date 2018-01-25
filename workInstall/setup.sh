#!/bin/bash
# This script was written for use on a Macbook Pro(2013) running ubuntu 16.04.3LTS

# VARIABLES
USER=''
PACKAGES='htop uprecords-cgi nload tcptrack unity-tweak-tool vim git rdesktop fping firmware-b43-installer sl tig icewm gnome-multi-writer'
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
mv *.jpg /home/$USER/Pictures
cd /home/$USER/Pictures
cp -f XzIdxBS.jpg /usr/share/backgrounds/warty-final-ubuntu.png

/usr/bin/gsettings set org.gnome.desktop.interface gtk-theme 'Flatabulous'
/usr/bin/gsettings set org.gnome.desktop.wm.preferences theme 'Flatabulous'
/usr/bin/gsettings set org.gnome.desktop.interface icon-theme 'Vivacious-Dark-Blue'
/usr/bin/gsettings set com.canonical.Unity.Launcher launcher-position Bottom

echo "Post-install has completed. Rebooting in 10 seconds..."
sleep 10
reboot
