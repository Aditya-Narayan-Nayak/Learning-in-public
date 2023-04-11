#!/bin/bash

# Update package information
sudo apt-get update

# Install snapd
sudo apt-get install snapd -y

# Install Microk8s
snap install microk8s --classic

# enable ingress dns storage
microk8s enable ingress dns storage

