#!/bin/bash

# Prerequisites

# t3.small (2 vCPUs, 2 GB RAM) is the smallest recommended.

## AWS CLI installed and configured
## eksctl installed
## AWS IAM user or role with necessary permissions

# Step 1: Create an EKS Cluster
eksctl create cluster --name=my-eks-cluster --region=us-east-1

# Verify it
eksctl get cluster

# Step 2: Add a Node Group
eksctl create nodegroup \ 
      --cluster=my-eks-cluster \ 
      --region=us-east-1 \ 
      --name=my-first-eks-nodegroup \ 
      --node-type=t3.medium \ 
      --nodes=2 \
      --nodes-min=1 \
      --nodes-max=2 \
      --ssh-access \
      --ssh-public-key=eks-pem.key 

# Or one command line
# eksctl create cluster --name my-eks-cluster --region us-east-1 --nodegroup-name my-eks-nodegroup --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 2 --managed

# eksctl delete cluster my-eks-cluster --region us-east-1

# aws eks update-kubeconfig --name cluster-name --region us-east-1