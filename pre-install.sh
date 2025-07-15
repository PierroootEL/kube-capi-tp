#!/bin/bash
set -e

## Made by Pierre B. - ESGI 2025

sudo dnf update -y && sudo dnf upgrade -y
sudo systemctl disable --now firewalld

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo --overwrite
sudo dnf install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker

sudo usermod -aG docker $USER
echo "Merci de vous déconnecter puis reconnecter pour valider l'attribution du groupe !"
newgrp docker
