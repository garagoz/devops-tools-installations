#!/bin/bash

# install gitlab runner

# Download the binary for your system
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permission to execute
sudo chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab Runner user
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as a service
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start

# Also install jre and maven
sudo apt install openjdk-17-jre maven -y

#sudo gitlab-runner register --url http://GITLAB_SERVER_IP/ --registration-token GR1348941xdGmuqBSLovUp4DDE8TK

# sudo find / -name .bash_logout
# sudo rm -r .bash_logout