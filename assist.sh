#!/usr/bin/env bash 

NC=$'\e[0m' # No Color
BOLD=$'\033[1m'
UNDERLINE=$'\033[4m'
RED=$'\e[31m'
GREEN=$'\e[32m'
BLUE=$'\e[34m'
ORANGE=$'\x1B[33m'

MAKEFILE_PATH="$(git rev-parse --show-toplevel)/.ci/Makefile"

function build(){
    directory=$1
    if [ ! -z $directory  ];then 
        cd $directory && make -f $MAKEFILE_PATH build && cd -
        return 0
    fi 

    # Build Base First
    cd base && make -f $MAKEFILE_PATH build && cd -
    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make -f $MAKEFILE_PATH build && cd -
        fi
    done 
    cd .cd/assembly/base && make -f $MAKEFILE_PATH build && cd -
    cd .cd/assembly && make -f $MAKEFILE_PATH build && cd -
    echo -e "${GREEN}All Containers Built successfully${NC}\n"
}

function push(){
    directory=$1
    if [ ! -z $directory  ];then 
        cd $directory && make -f $MAKEFILE_PATH push && cd -
        return 0
    fi 

    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make -f $MAKEFILE_PATH push && cd -
        fi
    done
    cd .cd/assembly && make push && cd -
    echo -e "${GREEN}All Containers Pushed successfully To Registry${NC}\n" 
}

function clean(){
    directory=$1
    if [ ! -z $directory  ];then 
        cd $directory && make -f $MAKEFILE_PATH clean && cd -
        return 0
    fi 

    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make -f $MAKEFILE_PATH clean && cd -
        fi
    done
    cd .cd/assembly && make push && cd -
    echo -e "${GREEN}All Containers Removed successfully from loacl system${NC}\n" 
}



opt="$1"
dir_path="$2"
choice=$( tr '[:upper:]' '[:lower:]' <<<"$opt" )

echo -e "\n${BLUE}Executing Action : $choice"

case ${choice} in
    "build")
        build  $dir_path
    ;;
    "push")
        push   $dir_path
    ;;
    "clean")
        clean  $dir_path
    ;;
    *)
    echo "${RED}Usage: assist.sh < build | push | clean > [dir_path] ${NC}"
    echo "${ORANGE}When dir_path is not povided actions runs on all dirs${NC}"
cat <<-EOF

Commands:
---------
  build       -> Build all Containers
  push        -> Push all Containers
  clean       -> Clean all Containers
  
EOF
    ;;
esac