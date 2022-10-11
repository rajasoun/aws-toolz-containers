#!/usr/bin/env bash

aws_resources=(
    accesskeys
    alarms
    availabilityzones
    buckets
    certificates
    classicloadbalancers
    containerclusters
    containerinstances
    containers
    containertasks
    databases
    dbsubnetgroups
    distributions
    elasticips
    functions
    groups
    images
    importimagetasks
    instanceprofiles
    instances
    internetgateways
    keypairs
    launchconfigurations
    listeners
    loadbalancers
    metrics
    mfadevices
    natgateways
    networkinterfaces
    policies
    queues
    records
    repositories
    roles
    routetables
    s3objects
    scalinggroups
    scalingpolicies
    securitygroups
    snapshots
    stacks
    subnets
    subscriptions
    targetgroups
    topics
    users
    volumes
    vpcs
    zones
)

function whoami(){
    { aws sts get-caller-identity & aws iam list-account-aliases; } | jq -s ".|add"
}

function list_aws_resources(){
    for resource in $aws_resources; do
        echo "## $resource"
        awless list $resource
    done
}


function list_aws_services_used_using_cost_explorer(){
    aws ce get-cost-and-usage \
        --time-period Start=$(date "+%Y-%m-01" -d "-1 Month"),End=$(date --date="$(date +'%Y-%m-01') - 1 second" -I) \
        --granularity MONTHLY \
        --metrics UsageQuantity \
        --group-by Type=DIMENSION,Key=SERVICE \
        | jq '.ResultsByTime[].Groups[] | select(.Metrics.UsageQuantity.Amount > 0) | .Keys[0]' | tr -d '"'
}

function list_aws_services_used_with_cost_using_cost_explorer(){
    aws ce get-cost-and-usage \
        --time-period Start=$(date "+%Y-%m-01"),End=$(date --date="$(date +'%Y-%m-01') + 1 month  - 1 second" -I) \
        --granularity MONTHLY \
        --metrics USAGE_QUANTITY BLENDED_COST  \
        --group-by Type=DIMENSION,Key=SERVICE \
        | jq '[ .ResultsByTime[].Groups[] | select(.Metrics.BlendedCost.Amount > "0") | { (.Keys[0]): .Metrics.BlendedCost } ] | sort_by(.Amount) | add'
}

function list_eks_pods(){
    #pod=$(kubectl get pods -o json | jq '.items[].spec.containers[].name' | sort | uniq | tr -d '"')
    REMOVE_FROM_WORD="-development"
    pod_list=$(kubectl get pods -o json | jq '.items[].metadata.name' |  sed "s/$REMOVE_FROM_WORD.*//" | sort | uniq | tr -d '"')
    echo $pod_list
}

function list_eks_non_running_pods(){
    kubectl get pods --field-selector=status.phase!=Running | grep -v Complete
}

function list_eks_services(){
    services=$(kubectl get svc -o json | jq '.items[].metadata.name' | sort | uniq | tr -d '"')
    WORD_TO_REMOVE="-development"
    for service in $services; do
        echo "$service" | sed "s/$WORD_TO_REMOVE//"
    done
}

function list_ingress_access_to_ports(){
    aws ec2 describe-security-groups \
        | jq '[ .SecurityGroups[].IpPermissions[] as $a | { "ports": [($a.FromPort|tostring),($a.ToPort|tostring)]|unique, "cidr": $a.IpRanges[].CidrIp } ] | [group_by(.cidr)[] | { (.[0].cidr): [.[].ports|join("-")]|unique }] | add'
}

function list_ec2_in_all_regions(){
    for region in $(aws ec2 describe-regions --output text | cut -f4);do
        echo -e "\nListing Instances in region:'$region'..."
        awless list instances --aws-region "$region"
    done
}

function check_lambda_functions_exposing_secret(){
    aws lambda list-functions \
        | jq -r '[.Functions[]|{name: .FunctionName, env: .Environment.Variables}]|.[]|select(.env|length > 0)'
}

function profile_aws_account(){
    export AWS_DEFAULT_REGION=${1:-'us-east-1'}
    echo Report for the region $AWS_DEFAULT_REGION
    echo Using Caller identity:
    awless whoami
    awless config set aws.region $AWS_DEFAULT_REGION
    aws configure set default.region $AWS_DEFAULT_REGION
    echo Confirmation of the region via 'aws configure get region' and awless
    aws configure get region
    awless whoami
    awless switch
    echo '## Instances '
    awless list instances
    echo '## Clusters '
    aws eks list-clusters   | jq '.clusters[]' | tr -d '"'
    echo '## Containers '
    awless list containers
    echo '## Loadbalancers '
    awless list loadbalancers

    echo '## Cognoto Identity pools'
    aws cognito-identity list-identity-pools --max-results 10 | jq '.IdentityPools[].IdentityPoolName' | tr -d '"'
    echo '## Cognito user pools'
    aws cognito-idp list-user-pools --max-result 10 | jq '.UserPools[].Name' | tr -d '"'
    echo '## S3 Buckets'
    awless list buckets
    echo '## Cloudformation stacks'
    awless list stacks
    echo '## Lambda functions '
    awless list functions
    echo '## Lauch configurations '
    awless list launchconfigurations
    echo '## Auto scaling groups '
    awless list scalinggroups
    echo '## SQS Queues '
    awless list queues
    echo '## SNS subscriptions '
    awless list subscriptions
    echo '## SNS topics '
    awless list topics
    echo '## API Gateway - REST APIs '
    aws apigateway get-rest-apis | jq '.items[] | {Name: .name, Tags: .tags}'
    echo '## API Gateway - Domain Names '
    aws apigateway get-domain-names | jq '.items[]'
    echo '## Databases '
    awless list databases
    echo '## Loadbalancers'
    awless list loadbalancers
    echo '## Classic loadbalancers'
    awless list classicloadbalancers
    echo '## Cloudfront distributions'
    awless list distributions
    echo '## Elastic IPs'
    awless list elasticips
}

function aws_profile_config() {
  if [ ! -f ~/.aws/config ]; then
    echo -e "You must have AWS profiles set up in ~/.aws/config"
    return 1
  fi

  local list=$(grep '^[[]profile' <~/.aws/config | awk '{print $2}' | sed 's/]$//')
  if [[ -z $list ]]; then
    echo -e "You must have AWS profiles set up in ~/.aws/config"
    return 1
  fi

  # if AWS_PROFILE is empty - Interative Mode
  if [ -z "$AWS_PROFILE" ];then
    local nlist=$(echo "$list" | nl)
    while [[ -z $AWS_PROFILE ]]; do
        export AWS_PROFILE=$(read -p "AWS profile? `echo $'\n\r'`$nlist `echo $'\n> '`" N; echo "$list" | sed -n ${N}p)
    done
  fi
}

function kube_config(){
    export cluster=Development
    export region=us-east-1
    export account_id=$(aws sts get-caller-identity --output text --query 'Account')


    aws eks update-kubeconfig --region $region  --name $cluster
    export KUBECONFIG=$KUBECONFIG:~/.kube/config
}

function set_env(){
    aws-sso
    aws_profile_config
    kube_config
    whoami
    echo -e "export AWS_PROFILE=$AWS_PROFILE" > .config/.aws/.env
    echo -e "export KUBECONFIG=$KUBECONFIG:~/.kube/config" >> .config/.aws/.env
    source .config/.aws/.env
}

function main(){
    whoami
    list_aws_resources
    list_aws_services_used_using_cost_explorer
    list_aws_services_used_with_cost_using_cost_explorer
    list_eks_pods
    list_eks_non_running_pods
    list_eks_services
    list_ingress_access_to_ports
    list_ec2_in_all_regions
    check_lambda_functions_exposing_secret

    aws_profile_config
    kube_config
    set_env
}

# Wrapper To Aid TDD
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  if ! main "$@"; then
    exit 1
  fi
fi
