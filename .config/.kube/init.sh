#!/usr/bin/env bash

function do_config(){
    AWS_PROFILE=${1:-"lcce-development"}
    AWS_REGION=${2:-"us-east-1"}
    CLUSTER=${3:-"Development"}

    echo -e "export AWS_PROFILE=$AWS_PROFILE" >  .config/.kube/eks.env
    echo -e "export AWS_REGION=$AWS_REGION"   >> .config/.kube/eks.env
    echo -e "export CLUSTER=$CLUSTER"          >> .config/.kube/eks.env
    echo -e "export KUBECONFIG=$KUBECONFIG:~/.kube/config" >> .config/.kube/eks.env
}

do_config $@
export $(grep -v '^#' .config/.kube/eks.env | xargs)
aws eks update-kubeconfig --region $AWS_REGION  --name $CLUSTER
