#!/bin/bash

# Update and install necessary packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo "Installing Docker and Minikube..." >> /tmp/startup-script.log

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "Docker installation completed successfully." >> /tmp/startup-script.log

# Add current user to the docker group
sudo usermod -aG docker $USER

echo "User $USER added to docker group. Please log out and log back in for the changes to take effect." >> /tmp/startup-script.log

# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

echo "Minikube installation completed successfully." >> /tmp/startup-script.log

# Start Minikube
minikube start --driver=docker --force

# Enable Minikube addons (optional)
# minikube addons enable dashboard
# minikube addons enable ingress

echo "Docker and Minikube installation completed successfully."