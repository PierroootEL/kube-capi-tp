#!/bin/bash
set -e

## Made by Pierre B. - ESGI 2025

sudo dnf update -y && sudo dnf upgrade -y
sudo systemctl disable --now firewalld

sudo systemctl disable --now firewalld
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io


sudo systemctl enable --now docker
sudo usermod -aG docker $USER
newgrp docker
docker run --rm hello-world

sleep 5

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

kind create cluster --name seed

curl -LO "https://dl.k8s.io/release/\$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

echo "Pause de 30 secondes le temps de laisser le cluster démarrer"
sleep 30

kubectl get pods -A

sleep 5

curl -Lo helm.tar.gz https://get.helm.sh/helm-v3.17.0-linux-amd64.tar.gz
tar -xzf helm.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/
rm -r helm.tar.gz
helm version

sleep 5

kubectl apply --server-side -f https://docs.k0smotron.io/v1.1.2/install.yaml

echo "Pause de 110 secondes pour laisser les pods démarrer"
sleep 110

kubectl get pods -n k0smotron

curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.10.3/clusterctl-linux-amd64 -o clusterctl
chmod +x clusterctl && sudo mv clusterctl /usr/local/bin/clusterctl
clusterctl version

clusterctl init --infrastructure k0sproject-k0smotron

echo "Pause de 60 secondes, intialisation de CAPI"
sleep 60

kubectl get pods -A | grep capi
