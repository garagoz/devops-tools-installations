#!/bin/bash

# Recommended requirement
#2 GB RAM or more
#2 vCPUs or more

sudo apt update -y
sudo apt-get install curl openssh-server ca-certificates tzdata perl postfix -y

# During the postfix installation, a configuration window will appear. Choose “Internet Site”

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt install gitlab-ce -y

sudo vim /etc/gitlab/gitlab.rb
# search this and change -> "external_url 'https://your_domain'"
sudo gitlab-ctl reconfigure