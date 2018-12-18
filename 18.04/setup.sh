#!/bin/bash
# This script was written for use on Ubuntu 18.04LTS

# VARIABLES
USER=''
BASIC_PACKAGES='vim htop git lm-sensors atom unity-tweak-tool vlc steam chromium-browser putty sl tig uprecords-cgi qemu-kvm libvirt-bin bridge-utils virt-manager gnome-multi-writer minecraft-installer neofetch rename dconf-editor'
SYSADMIN_PACKAGES='nmap fping rdesktop tcptrack nload'
THEMES='ultra-flat-icons arc-theme papirus-icon-theme'
DISCORD_VERSION='0.0.5'

# Check if user is root
if ! whoami | grep -q root; then
  echo "Please restart this script as root"
  exit 1
else
  continue
fi

# Add theme repos before update
sudo add-apt-repository ppa:papirus/papirus -y

# Initial Update
apt-get update && sudo apt-get upgrade -y
apt-get dist-upgrade -y

# Basic linux stuff
apt-get install $BASIC_PACKAGES -y

# Sysadmin related packages
apt-get install $SYSADMIN_PACKAGES -y

# Install themes
apt-get install $THEMES -y

git clone https://github.com/vinceliuice/vimix-gtk-themes.git /opt/vimix
cd /opt/vimix && ./Install

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


# Change DE settings

# Set icon and window theme
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
gsettings set org.gnome.desktop.interface gtk-theme Vimix-dark-doder

# Make clicking active window icon minimize window
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# Place dash on bottom
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM

# Icon size adjustment
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 36

# Set keyboard shortcut for wallpaper script
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Run wallpaper script'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'notify-send "help"'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Launch1'

# Disable accidental screenshot button presses
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot ''

# Show date in top bar
gsettings set org.gnome.desktop.interface clock-show-date true

# Show battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true

