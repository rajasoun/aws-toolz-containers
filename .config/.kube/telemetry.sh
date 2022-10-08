#!/usr/bin/env bash

export cluster=Development
export region=us-east-1
export account_id=$(aws sts get-caller-identity --output text --query 'Account')


aws eks update-kubeconfig --region $region  --name $cluster
export KUBECONFIG=$KUBECONFIG:~/.kube/config

pod=$(kubectl get pods -o json | jq '.items[].spec.containers[].name' | sort | uniq | tr -d '"')
pod=$(kubectl get pods -o json | jq '.items[].metadata.name' | sort | uniq | tr -d '"')

services=$(kubectl get svc -o json | jq '.items[].metadata.name' | sort | uniq | tr -d '"')
for service in @services;do
    echo $service
done
