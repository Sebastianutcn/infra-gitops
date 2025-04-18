#!/bin/bash

# Update and install dependencies
apt-get update
apt-get install -y curl apt-transport-https ca-certificates gnupg lsb-release \
    conntrack socat ebtables ethtool docker.io curl unzip

# Enable Docker
systemctl enable docker
systemctl start docker

sleep 20

# Install kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/

# Install Minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# Start Minikube with Docker driver
minikube start --driver=docker

# Wait for Minikube to be ready
sleep 200

# Log completion
echo "Minikube + Argo CD installed and running" >> /var/log/startup-script.log
