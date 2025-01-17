#!/bin/bash

# first install docker on your machine

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

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo service docker restart
sudo chmod 666 /var/run/docker.sock
sudo systemctl restart docker

# creating data directory for nexus
docker volume create --name nexus-data

# run nexus image
docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3

# get nexus default password
docker container exec nexus cat nexus-data/admin.password