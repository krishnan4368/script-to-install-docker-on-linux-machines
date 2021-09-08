#!/bin/bash
# This is a simple script to install docker on Ubuntu machines.

# Installing Docker Dependencies
function installDependencies() {
echo 'Installing Dependencies'
sudo apt-get update >> /dev/null 2>$1
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release > /dev/null 2>&1
}

# Configure Docker Repository and install Docker
function installDockerEngine() {
echo 'Configuring Docker Repository'
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update >> /dev/null 2>$1
echo 'Installing Docker Engine'
sudo apt-get install docker-ce docker-ce-cli containerd.io >> /dev/null 2>&1
sudo usermod --append --groups docker "$USER" >> /dev/null 2>&1
  }

# Enable and restart Docker
function enableDockerEngine() {
echo 'Starting Docker Service'
sudo systemctl enable docker.service
sudo systemct restart docker.service
  }

# Install Docker-Compose
function installDockerCompose() {
echo 'Installing Docker Compose'
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose >> /dev/null 2>&1
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose 
  echo 'Done, Happy Coding!'
  }
  
installDependencies
installDockerEngine
enableDockerEngine
installDockerCompose
