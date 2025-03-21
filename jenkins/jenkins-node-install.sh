#!/bin/bash

# Jenkins node server installation for builds
# Create a ec2 instance or any virtual machine

# create key pair with ssh-keygen
# 1. add private key to jenkins credentials
# 2. add public key to at the end of authorized_key file

sudo apt update -y
sudo apt install fontconfig openjdk-17-jre -y
sudo cd /home/ubuntu
sudo mkdir jenkins-slave
sudo chmod 755 jenkins-slave

# Go to Jenkins
# 1. Manage Jenkins -> Nodes -> New Node -> Enter node name and select Permanent agent    
# 2. Remote root directory -> /home/ubuntu/jenkins-slave
# 3. labels -> node1
# 4. Launch method -> Launch agents via ssh
# 5. Host -> enter jenkins slave host ip or domain
# 6. Credentials -> selected credential already added
# 7. Host Key Verification Strategy -> Non verifying Verification Strategy
# 8. Save and Launch node
