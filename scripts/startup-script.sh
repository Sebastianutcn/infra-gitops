#!/bin/bash

# Exit on any error
set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print status
log() {
    echo "[INFO] $1"
}

# Check for sudo privileges
if [ "$(id -u)" != "0" ]; then
    log "This script requires sudo privileges. Running with sudo..."
    exec sudo "$0" "$@"
fi

# Update package list
log "Updating package list..."
apt-get update -y

# Install prerequisites
log "Installing prerequisites (curl, apt-transport-https)..."
apt-get install -y curl apt-transport-https ca-certificates software-properties-common

# Install Docker
if command_exists docker; then
    log "Docker is already installed."
else
    log "Installing Docker..."
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
    usermod -aG docker "${SUDO_USER:-$USER}"
    log "Docker installed and configured."
fi

# Install kubectl
if command_exists kubectl; then
    log "kubectl is already installed."
else
    log "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mv kubectl /usr/local/bin/
    log "kubectl installed."
fi

# Install Minikube
if command_exists minikube; then
    log "Minikube is already installed."
else
    log "Installing Minikube..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
    log "Minikube installed."
fi

# Verify installations
log "Verifying installations..."
if command_exists docker; then
    log "Docker version: $(docker --version)"
else
    log "Error: Docker not installed correctly."
    exit 1
fi

if command_exists kubectl; then
    log "kubectl version: $(kubectl version --client --output=yaml)"
else
    log "Error: kubectl not installed correctly."
    exit 1
fi

if command_exists minikube; then
    log "Minikube version: $(minikube version)"
else
    log "Error: Minikube not installed correctly."
    exit 1
fi

# Start Minikube
log "Starting Minikube with Docker driver..."
minikube start --driver=docker --force

# Verify Minikube cluster
log "Verifying Minikube cluster..."
minikube status
kubectl config use-context minikube
log "kubectl configured to use Minikube cluster."

log "Minikube setup complete!"
log "To interact with the cluster, use 'kubectl' commands."

exit 0