#!/bin/bash
set -e

# Install Docker
apt-get update
apt-get install -y docker.io curl conntrack

# Enable Docker
systemctl start docker
systemctl enable docker
usermod -aG docker $USER
newgrp docker

# Install Minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# Start Minikube
minikube start --driver=docker

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

