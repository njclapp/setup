#!/bin/bash
# This script was written for use on Ubuntu 18.04LTS

# TODO 18 Dec 2018
# - add other wallpaper downloads
# - git clone wallpaper script and place in /usr/local/bin
# - formatting/spacing
# - functions? menu?

# VARIABLES
USER=''
BASIC_PACKAGES='vim htop git tig lm-sensors atom unity-tweak-tool vlc steam chromium-browser putty sl tig uptimed qemu-kvm libvirt-bin bridge-utils virt-manager gnome-multi-writer neofetch rename dconf-editor'
SYSADMIN_PACKAGES='nmap fping rdesktop tcptrack nload'
THEMES='ultra-flat-icons arc-theme papirus-icon-theme'
DISCORD_VERSION='0.0.5'

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check if user is root
if ! whoami | grep -q root; then
  echo -e "${RED}Please restart this script as root${NC}"
  exit 1
else
  continue
fi

# Add theme repos before update
echo -e "${GREEN}Adding theme repositories...${NC}"
sudo add-apt-repository ppa:papirus/papirus -y

# Initial Update
echo -e "${GREEN}Updating and upgrading system...${NC}"
apt-get update && sudo apt-get upgrade -y
apt-get dist-upgrade -y

# Basic linux stuff
echo -e "${GREEN}Installing packages...${NC}"
apt-get install $BASIC_PACKAGES -y

# Sysadmin related packages
apt-get install $SYSADMIN_PACKAGES -y

# Install themes
echo -e "${GREEN}Installing themes...${NC}"
apt-get install $THEMES -y

echo -e "${GREEN}Cloning vimix and installing...${NC}"
git clone https://github.com/vinceliuice/vimix-gtk-themes.git /opt/vimix
cd /opt/vimix && ./Install

# Move dotfiles
echo -e "${GREEN}Moving .bashrc and .vimrc to user directory...${NC}"
mv .bashrc /home/$USER/; chown $USER:$USER /home/$USER/.bashrc
mv .vimrc /home/$USER/; chown $USER:$USER /home/$USER/.vimrc

# Create picture directories
echo -e "${GREEN}Creating picture directories...${NC}"
mkdir /home/$USER/Pictures/sun_positionals /home/$USER/Pictures/wallpapers /home/$USER/Pictures/light /home/$USER/Pictures/dark

# Get sun positionals
echo -e "${GREEN}Downloading positional sun pictures...${NC}"
cd /home/$USER/Pictures/sun_positionals
images=( "tH4MNmw" "Ewq4wIU" "a0Jb6AB" "ikxyP4q" "FFB6rrg" "5NfSHYL" "2LXn7o2" "3K6O7BH" )
names=( "morning" "late_morning" "afternoon" "late_afternoon" "evening" "late_evening" "night" "late_night" )

for i in ${!array[@]}
do
	wget -4 https://imgur.com/${images[$i]}.png -O ${names[$i]}.png
done


# Get wallpapers
cd /home/$USER/Pictures/wallpapers
wget -4 https://imgur.com/a/29jWnHn/zip && unzip zip && rm -rf zip

# Download/Install VS Code (Manually)
echo -e "${GREEN}Installing VS Code...${NC}"
firefox https://code.visualstudio.com/Download &
read -p "Install VS Code manually, then press enter..."

# Change DE settings
# Set icon and window theme
echo -e "${GREEN}Setting themes...${NC}"
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
gsettings set org.gnome.desktop.interface gtk-theme Vimix-dark-doder

echo -e "${GREEN}Adjusting desktop settings...${NC}"
# Make clicking active window icon minimize window
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
# Place dash on bottom
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
# Icon size adjustment
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 36
# Show date in top bar
gsettings set org.gnome.desktop.interface clock-show-date true
# Show battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Set keyboard shortcut for wallpaper script
echo -e "${GREEN}Setting hotkey for wallpaper script...(thinkpad black button)${NC}"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Run wallpaper script'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'notify-send "help"'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Launch1'

# Disable accidental screenshot button presses
echo -e "${GREEN}Disabling screenshot button...(you're welcome)${NC}"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot ''

echo -e "${GREEN}setup.sh has completed successfully. Please reboot your computer${NC}"
echo -e "${GREEN}to start using it.${NC}"