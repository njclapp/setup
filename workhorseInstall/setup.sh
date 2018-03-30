#!/bin/bash
# This script was written for use on ubuntu server 16.04.4LTS

# VARIABLES
HOSTNAME='workhorse'
USER=''
PACKAGES='apache2 deluge-web docker samba ssh git fortune cowsay lm-sensors tig make uptimed'
ADMINISTRATION_PACKAGES='nload htop nmap fping tcptrack'
GREEN='\033[0;32m'
RED='\033[0;31m'
PLAINTEXT='\033[0m'


if ! whoami | grep -q root; then
	echo "${RED}[!] Please run this script as root!${PLAINTEXT}"
    exit 1
else
  continue
fi

# Initial Update
echo "${GREEN}[+] Updating System...1/9${PLAINTEXT}"
apt-get update && apt-get upgrade -y
apt-get dist-upgrade -y

# Add/Clone Repos
echo "${GREEN}[+] Cloning Repositories...2/9${PLAINTEXT}"
git clone https://github.com/dylanaraps/neofetch.git /home/$USER/neofetch

# Install Packages
echo "${GREEN}[+] Installing Packages...3/9${PLAINTEXT}"
apt-get install $PACKAGES -y
apt-get install $ADMINISTRATION_PACKAGES -y

# Set up lm-sensors
echo "${GREEN}[+] Initializing lm-sensors...4/9${PLAINTEXT}"
sensors-detect --auto

# Move Dotfiles
echo "${GREEN}[+] Moving Dotfiles...5/9${PLAINTEXT}"
mv dotfiles/.bashrc /home/$USER/
mv dotfiles/.vimrc /home/$USER/
mv dotfiles/interfaces /etc/network/
mv dotfiles/smb.conf /etc/samba/
mv dotfiles/sshd_config /etc/ssh/

# Set up samba
echo "${GREEN}[+] Adding User $USER to Samba...6/9${PLAINTEXT}"
smbpasswd -a $USER

# Initialize ufw rules
echo "${GREEN}[+] Initializing UFW...7/9${PLAINTEXT}"
. functions/initUFW.sh

# Change Hostname
echo "${GREEN}[+] Changing Hostname...8/9${PLAINTEXT}"
hostn=$(cat /etc/hostname)
sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hosts
sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hostname

# Disable IPv6
echo "${GREEN}[+] Disabling IPv6...9/9${PLAINTEXT}"
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

# Script is finished. Wait and reboot
echo "Post-install has completed. Rebooting in 10 seconds..."
sleep 10
reboot
