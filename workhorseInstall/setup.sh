#!/bin/bash
# This script was written for use on ubuntu server 16.04.4LTS

# VARIABLES
HOSTNAME='workhorse'
USER=''
PACKAGES='apache2 deluge-web docker samba ssh git ddclient fortune cowsay lm-sensors tig'
ADMINISTRATION_PACKAGES='nload htop nmap fping tcptrack'
COLOR='\033[0;32m'
PLAINTEXT='\033[0m'


if ! whoami | grep -q root; then
    echo "Please restart this script as root"
    exit 1
else
  continue
fi

# Initial Update
echo -e "${COLOR}[+] Updating System...1/8${PLAINTEXT}"
apt-get update && apt-get upgrade -y
apt-get dist-upgrade -y

# Add/Clone Repos
echo -e "${COLOR}[+] Cloning Repositories...2/8${PLAINTEXT}"
git clone https://github.com/dylanaraps/neofetch.git
cd neofetch
make install
cd ..

# Install Packages
echo -e "${COLOR}[+] Installing Packages...3/8${PLAINTEXT}"
apt-get install $PACKAGES -y
apt-get install $ADMINISTRATION_PACKAGES -y

# Set up lm-sensors
echo -e "${COLOR}[+] Initializing lm-sensors...4/8${PLAINTEXT}"
sensors-detect --auto

# Move Dotfiles
echo -e "${COLOR}[+] Moving Dotfiles...5/8${PLAINTEXT}"
mv dotfiles/.bashrc /home/$USER/
mv dotfiles/.vimrc /home/$USER/
mv dotfiles/interfaces /etc/network/
mv dotfiles/smb.conf /etc/samba/
mv dotfiles/sshd_config /etc/ssh/

# Set up samba
echo -e "${COLOR}[+] Adding User $USER to Samba...6/8${PLAINTEXT}"
smbpasswd -a $USER

# Initialize ufw rules
echo -e "${COLOR}[+] Initializing UFW...7/8${PLAINTEXT}"
. functions/initUFW.sh

# Change Hostname
echo -e "${COLOR}[+] Changing Hostname...8/8${PLAINTEXT}"
hostn=$(cat /etc/hostname)
sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hosts
sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hostname

# Script is finished. Wait and reboot
echo "Post-install has completed. Rebooting in 10 seconds..."
sleep 10
reboot