#!/bin/bash

KUBERNETES_VERSION = v1.31

sudo swapoff -a # To disable swap
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true

# By default, Kubernetes uses the Container Runtime Interface (CRI) 

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF
# Apply sysctl params without reboot
sudo sysctl --system

sudo modprobe overlay
sudo modprobe br_netfilter

# Verify that net.ipv4.ip_forward is set to 1 with
sysctl net.ipv4.ip_forward

# install containerd
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

containerd config default > /etc/containerd/config.toml

# set SystemdGroup to true
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
sudo systemctl restart containerd


# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
# Attention: change kubeadm version whatever you want
curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl -y



# ------------------------------------------------------------------
# Creatng cluster with kubeadm, run this only one machine

# kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=192.168.56.101
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
# kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml





# sudo apt-mark unhold kubeadm && sudo apt-get update && sudo apt-get install -y kubeadm='1.32.0-1.1' && sudo apt-mark hold kubeadm

# sudo apt-mark unhold kubelet kubectl && 
# sudo apt-get update && sudo apt-get install -y kubelet='1.32.0-1.1' kubectl='1.32.0-1.1' && 
# sudo apt-mark hold kubelet kubectl