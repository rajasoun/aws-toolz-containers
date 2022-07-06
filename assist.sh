#!/usr/bin/env bash 

NC=$'\e[0m' # No Color
BOLD=$'\033[1m'
UNDERLINE=$'\033[4m'
RED=$'\e[31m'
GREEN=$'\e[32m'
BLUE=$'\e[34m'
ORANGE=$'\x1B[33m'

function build(){
    # Build Base First
    cd base && make -f ../.ci/Makefile build && cd -
    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make -f ../.ci/Makefile build && cd -
        fi
    done
     echo -e "${GREEN}All Containers Built successfully${NC}\n" 
}

function push(){
    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make -f ../.ci/Makefile push && cd -
        fi
    done
     echo -e "${GREEN}All Containers Pushed successfully To Registry${NC}\n" 
}

function clean(){
    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make -f ../.ci/Makefile clean && cd -
        fi
    done
     echo -e "${GREEN}All Containers Removed successfully from loacl system${NC}\n" 
}



opt="$1"
choice=$( tr '[:upper:]' '[:lower:]' <<<"$opt" )

echo -e "\n${BLUE}Executing Action : $choice"

case ${choice} in
    "build")
        build
    ;;
    "push")
        push
    ;;
    "clean")
        clean
    ;;
    *)
    echo "${RED}Usage: assist.sh < setup | teardown >  ${NC}"
cat <<-EOF
Commands:
---------
  build       -> Build all Containers
  push        -> Push all Containers
  clean       -> Clean all Containers
  
EOF
    ;;
esac