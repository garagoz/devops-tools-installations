#!/bin/bash

# Prerequisites

## AWS CLI installed and configured
## eksctl installed
## AWS IAM user or role with necessary permissions

# Step 1: Create an EKS Cluster
eksctl create cluster --name=my-first-eks-cluster --region=us-east-1

# Verify it
eksctl get cluster

# Step 2: Add a Node Group
eksctl create nodegroup \ 
      --cluster=my-first-eks-cluster \ 
      --region=us-east-1 \ 
      --name=my-first-eks-nodegroup \ 
      --node-type=t3.medium \ 
      --nodes=3 \
      --nodes-min=2 \
      --nodes-max=4 \
      --ssh-access \
      --ssh-public-key=eks-pem.key 