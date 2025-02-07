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
# Plugins to install
# Maven integration
# Github integration
# Nexus Artifact Uploader
# Build Timestamp
# SonarQube Scanner
# Slack Notification 
# OWASP Dependency check
# Config File Provider
# Eclipse Temurin, needs for easy jdk installation
# Docker
# Docker Pipeline
# docker-build-step

# --- needs for AWS cloud---
# CloudBees Docker Build and Publish
# Amazon ECR
# Pipeline: AWS Steps

# ----- if you work with Gitlab ----
# GitLab
# GitLab API

# ---- For Kubernetes -----
# Kubernetes
# Kubernetes CLI
# Kubernetes Client API
# Kubernetes Credentials

# -------------------------------
# jenkins go to Tools
# add jdk path
# add maven3

# https://github.com/jaiswaladi246/secretsanta-generator.git