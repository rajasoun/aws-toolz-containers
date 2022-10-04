#!/usr/bin/env bash

export $(grep -v '^#' .env | xargs)

# Check Connection
function check_vpn_connection() {
  server=$1
  port=$2
  if nc -z "$server" "$port" 2>/dev/null; then
    echo -e "${GREEN}VPN Connection $server Passed ✅ ${NC}\n"
    return 0
  else
    echo -e "${RED}VPN Connection $server Failed ❌ ${NC}\n"
    return 1
  fi
}

function git_clone(){
    if [ ! -d duo-sso ];then 
        git clone https://$VPN_GIT_HOST/ATS-operations/duo-sso/
    fi
}

function build_linux_bin(){
    cd duo-sso
    if [ ! -f build/duo-sso_linux_amd64 ];then 
        BUILD_IMAGE=golang:1.19
        mkdir -p build
        docker pull "$BUILD_IMAGE"
        docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp -e GOOS=linux -e GOARCH=amd64 "$BUILD_IMAGE" go build -o build/aws-sso
    fi
    cd -
}

function main(){
    if [ ! -f bin/aws-sso ];then 
        check_vpn_connection "$VPN_GIT_HOST" 443 || return 1
        git_clone
        build_linux_bin
        mv duo-sso/build/aws-sso bin/aws-sso
    fi 
}

main $@





