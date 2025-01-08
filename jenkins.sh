#!/bin/bash
sudo apt update -y
sudo apt install fontconfig openjdk-17-jre -y

# also install maven 
sudo apt install maven -y

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  
sudo apt-get update -y
sudo apt-get install jenkins -y

#  ---------------------------------------
# After setup jenkins install these plugins
# Maven integration
# Github integration
# Nexus Artifact Uploader
# Build Timestamp
# SonarQube Scanner
# Sonar Quality Gates
# Slack Notification 
# Config File Provider

# jenkins go to Tools
# add jdk path
# add maven3