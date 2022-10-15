#!/usr/bin/env bash

AWS_PROFILE=${1:-"lcce-development"}
AWS_REGION=${2:-"us-east-1"}
CLUSTER=${3:-"Development"}

aws eks update-kubeconfig --region $AWS_REGION  --name $CLUSTER

export AWS_PROFILE
export AWS_REGION
export CLUSTER
export KUBECONFIG=$KUBECONFIG:~/.kube/config
