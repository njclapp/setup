#!/bin/bash

USER=$1

if [[ -z $1 ]]
then
  echo 'Need to place username after script like this: ./setup.sh <username>'
  exit
fi

# Install basic tools
sudo apt install -y git htop kdeconnect keepass2 putty tig tmux vim

# Install docker services
sudo apt install -y docker.io docker-compose
sudo echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo usermod -aG docker $USER

# Install KVM services
sudo apt install -y qemu-kvm virt-manager libvirt-daemon-system virtinst libvirt-clients bridge-utils

# Install steam
cd /tmp
wget -4 https://cdn.akamai.steamstatic.com/client/installer/steam.deb
sudo dpkg -i steam*.deb
sudo apt install -f -y # Used to clean up dependencies

# Install Veracrypt
wget -4 https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Ubuntu-23.04-amd64.deb
sudo dpkg -i veracrypt-1.26.7-Ubuntu-23.04-amd64.deb
sudo apt install -f -y # Used to clean up dependencies

# Install Minecraft
wget -4 https://launcher.mojang.com/download/Minecraft.deb
sudo dpkg -i Minecraft.deb
sudo apt install -f -y # Used to clean up dependencies

# Install kubectl
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update && sudo apt install kubectl -y
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'export KUBECONFIG=~/.kube/config' >> ~/.bashrc
