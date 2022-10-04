#!/usr/bin/env bash

export cluster=eks
export region=us-east-1
export account_id=$(aws sts get-caller-identity --output text --query 'Account')


aws eks update-kubeconfig --region $region --name $cluster
export KUBECONFIG=$KUBECONFIG:~/.kube/config
