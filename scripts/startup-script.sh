#!/bin/bash
set -e

# Install Docker
apt-get update
apt-get install -y docker.io curl conntrack

# Enable Docker
systemctl enable docker
systemctl start docker

# Install Minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Start Minikube
minikube start --driver=docker


