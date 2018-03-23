#!/bin/bash
# This script was written for use on ubuntu server 16.04.4LTS

# VARIABLES
HOSTNAME='workhorse'
USER=''
PACKAGES='apache2 deluge-web docker samba ssh git ddclient fortune cowsay sensors ufw'
NETWORK_PACKAGES='nload htop nmap fping tcptrack'

if ! whoami | grep -q root; then
    echo "Please restart this script as root"
    exit 1
else
  continue
fi

# Move Dotfiles

# Initial Update
apt-get update && sudo apt-get upgrade -y
apt-get dist-upgrade -y

# Add/Clone Repos

# Install Packages
apt-get install $PACKAGES -y
apt-get install $NETWORK_PACKAGES -y

# Set up lm-sensors
sensors-detect --auto

# Change Hostname
hostn=$(cat /etc/hostname)
sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hosts
sudo sed -i "s/$hostn/$HOSTNAME/g" /etc/hostname

# Script is finished. Wait and reboot
echo "Post-install has completed. Rebooting in 10 seconds..."
sleep 10
reboot
