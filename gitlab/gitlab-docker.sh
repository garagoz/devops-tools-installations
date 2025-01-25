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

# pull gitlab image
sudo docker pull gitlab/gitlab-ce:latest

# Create a directory to store GitLab’s configuration and data
sudo mkdir -p /gitlab/config /gitlab/logs /gitlab/data

sudo docker run --detach \
  --hostname YOUR_SERVER_IP \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume /gitlab/config:/etc/gitlab \
  --volume /gitlab/logs:/var/log/gitlab \
  --volume /gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest

# Set a new password for your GitLab CE with Docker panel
sudo docker exec -it gitlab /bin/bash

# inside the container’s shell, run the following command to reset the root user’s password:
# gitlab-rake "gitlab:password:reset"

# Access GitLab CE with Docker web interface http://YOUR_SERVER_IP 
