#!/bin/bash
# This script was written for use on Ubuntu 18.04LTS

# TODO 19 Dec 2018
# - functions? menu?
# - virt-manager setup?
# - Add install atom section

# VARIABLES
USER='nate'
BASIC_PACKAGES='vim htop git tig lm-sensors unity-tweak-tool vlc steam chromium-browser putty sl tig uptimed qemu-kvm libvirt-bin bridge-utils virt-manager gnome-multi-writer neofetch dconf-editor keepass2 xdotool'
SYSADMIN_PACKAGES='nmap fping rdesktop tcptrack nload'
THEMES='arc-theme papirus-icon-theme' # ultra-flat-icons #not installing for now
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

# Set up lm-sensors
echo -e "${GREEN}Detecting thermal sensors...${NC}"
sensors-detect --auto

# Install themes
echo -e "${GREEN}Installing themes...${NC}"
apt-get install $THEMES -y

echo -e "${GREEN}Cloning vimix and installing...${NC}"
git clone https://github.com/vinceliuice/vimix-gtk-themes.git /opt/vimix
./opt/vimix/Install

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
sun_images=( 
"tH4MNmw"
"Ewq4wIU"
"a0Jb6AB"
"ikxyP4q"
"FFB6rrg"
"5NfSHYL"
"2LXn7o2"
"3K6O7BH" )

sun_names=( 
"morning"
"late_morning"
"afternoon"
"late_afternoon"
"evening"
"late_evening"
"night"
"late_night" )

for i in ${!sun_images[@]}
do
	wget -4 https://imgur.com/${sun_images[$i]}.png -O ${sun_names[$i]}.png
done

# Get dark wallpapers
echo -e "${GREEN}Downloading dark wallpapers...${NC}"
cd /home/$USER/Pictures/dark
dark_image=( 
"r4EWCmy.jpg"
"hJRYN5d.png"
"6UYLJEF.jpg"
"RgAUp2X.jpg"
"NHyq8Eu.jpg"
"Xx7j1dk.png"
"y118SN0.jpg"
"uR4KQWV.jpg"
"4iEViiI.png"
"cqkQmb9.jpg" )

dark_name=( 
"climbing.jpg"
"CowSpaceship.png"
"debian_dark.jpg"
"FalloutNV.jpg"
"fez.jpg"
"forest.png"
"House.jpg"
"LotR.jpg"
"LPGold.png"
"Tower.jpg" )

for i in ${!dark_image[@]}
do
	wget -4 https://imgur.com/${dark_image[$i]} -O ${dark_name[$i]}
done

# Get light wallpapers
echo -e "${GREEN}Downloading light wallpapers...${NC}"
cd /home/$USER/Pictures/light
light_image=( 
"araFdUA.jpg"
"PviM8jH.png"
"ZJkX70u.jpg"
"r7uXGbp.jpg"
"lN6kQ6Q.jpg"
"Nlit893.png"
"P6gPh1e.jpg"
"5NiPvCW.jpg"
"wuAO6TY.jpg"
"FyF2b5z.jpg"
"ilWXMNO.png"
"mW8T5h0.png"
"zT9xOlc.png"
"HTMhCm2.jpg"
"Wo4hILU.jpg"
"UP05vac.jpg"
"nxEM3qQ.jpg"
 )

light_name=( 
"debian_light.jpg"
"doge.png"
"lenny.jpg"
"firewatch1.jpg"
"firewatch2.jpg"
"mountain.png"
"simple.jpg"
"lake.jpg"
"firewatch3.jpg"
"NoMansSky.jpg"
"NoMansSky2.png"
"lines.png"
"yosemite.png"
"skyrim2.jpg"
"rain.jpg"
"wind.jpg"
"skyrim.jpg" )

for i in ${!light_image[@]}
do
	wget -4 https://imgur.com/${light_image[$i]} -O ${light_name[$i]}
done

# Install wallpaper changer scripts to /usr/local/bin
git clone https://github.com/njclapp/background_changer /home/$USER/Desktop/background_changer
cd /home/$USER/Desktop/background_changer/
/bin/sh setup.sh
(crontab -u $USER -l; echo "@reboot /usr/local/bin/sun_changer") | crontab -u $USER -
(crontab -u $USER -l; echo "0 * * * * /usr/local/bin/sun_changer") | crontab -u $USER -

# Download/Install VS Code (Manually)
#echo -e "${GREEN}Installing VS Code...${NC}"
#firefox https://code.visualstudio.com/Download &
#read -p "Install VS Code manually, then press enter..."

# Change DE settings
# Set icon and window theme
echo -e "${GREEN}Setting themes...${NC}"
/usr/bin/gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
/usr/bin/gsettings set org.gnome.desktop.interface gtk-theme Vimix-dark-doder

echo -e "${GREEN}Adjusting desktop settings...${NC}"
# Make clicking active window icon minimize window
/usr/bin/gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
# Place dash on bottom
/usr/bin/gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
# Icon size adjustment
/usr/bin/gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 36
# Show date in top bar
/usr/bin/gsettings set org.gnome.desktop.interface clock-show-date true
# Show battery percentage
/usr/bin/gsettings set org.gnome.desktop.interface show-battery-percentage true

# Set keyboard shortcut for wallpaper script
echo -e "${GREEN}Setting hotkey for wallpaper script...(thinkpad black button)${NC}"
/usr/bin/gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
/usr/bin/gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Run wallpaper script'
/usr/bin/gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command '/usr/local/bin/background-change'
/usr/bin/gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Launch1'

# Disable accidental screenshot button presses
echo -e "${GREEN}Disabling screenshot button...(you're welcome)${NC}"
/usr/bin/gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot ''

echo -e "${GREEN}setup.sh has completed successfully. Please reboot your computer${NC}"
echo -e "${GREEN}to start using it.${NC}"
