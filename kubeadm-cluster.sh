sudo apt-mark unhold kubeadm && sudo apt-get update && sudo apt-get install -y kubeadm='1.32.0-1.1' && sudo apt-mark hold kubeadm

sudo apt-mark unhold kubelet kubectl && 
sudo apt-get update && sudo apt-get install -y kubelet='1.32.0-1.1' kubectl='1.32.0-1.1' && 
sudo apt-mark hold kubelet kubectl