#!/usr/bin/env bash

function create_iam_role(){
    EKS_CLUSTER_ROLE=$1
    # Create AWS IAM role
    aws iam create-role \
        --role-name $EKS_CLUSTER_ROLE \
        --assume-role-policy-document file://"cluster-trust-policy.json"
}

function delete_iam_role(){
    EKS_CLUSTER_ROLE=$1
    # delete AWS IAM role
    aws iam create-role \

}

function attach_iam_policy_to_role(){
    EKS_CLUSTER_ROLE=$1
    # Attach AWS IAM Policy to role
    aws iam attach-role-policy \
        --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy \
        --role-name $EKS_CLUSTER_ROLE
}

function dettach_iam_policy_to_role(){
    EKS_CLUSTER_ROLE=$1
    # Attach AWS IAM Policy to role
    aws iam dettach-role-policy \
        --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy \
        --role-name $EKS_CLUSTER_ROLE
}

function create_eks_cluster(){
    eksctl create cluster --config-file cluster-1.23.yaml
    eksctl get  clusters --region us-east-2
}

function delete_eks_cluster(){
    eksctl delete  cluster --config-file  cluster-1.23.yaml
}

function main(){
    EKS_CLUSTER_ROLE="eks"
    create_iam_role $@
    delete_iam_role $@
    attach_iam_policy_to_role $@
    dettach_iam_policy_to_role $@
}

# Wrapper To Aid TDD
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  if ! main "$@"; then
    exit 1
  fi
fi
