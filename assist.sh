#!/usr/bin/env bash 

NC=$'\e[0m' # No Color
BOLD=$'\033[1m'
UNDERLINE=$'\033[4m'
RED=$'\e[31m'
GREEN=$'\e[32m'
BLUE=$'\e[34m'
ORANGE=$'\x1B[33m'


function setup(){
    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cp .ci/template/Makefile "$directory" # copy .ci/template/Makefile into it
        fi
    done
     echo -e "${GREEN}Makefile Injected to all sub-directories successfully${NC}\n" 
}

function teardown(){
    find .  -name "Makefile" -not -path "./.ci/*" -delete
    echo -e "${GREEN}Makefile Deleted from all sub-directories  successfully${NC}\n" 
}

function build(){
    # Build Base First
    cd base && make build && cd -
    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make build && cd -
        fi
    done
     echo -e "${GREEN}All Containers Built successfully${NC}\n" 
}

function push(){
    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make push && cd -
        fi
    done
     echo -e "${GREEN}All Containers Pushed successfully To Registry${NC}\n" 
}

function clean(){
    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make clean && cd -
        fi
    done
     echo -e "${GREEN}All Containers Removed successfully from loacl system${NC}\n" 
}



opt="$1"
choice=$( tr '[:upper:]' '[:lower:]' <<<"$opt" )

echo -e "\n${BLUE}Executing Action : $choice"

case ${choice} in
    "setup")
        setup 
    ;;
    "teardown")
        teardown 
    ;;
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
  setup       -> Inject Makefile to all sub directories from .ci/template
  teardown    -> Delete Makefile from all sub directories
  build       -> Build all Containers
  push        -> Push all Containers
  clean       -> Clean all Containers
  
EOF
    ;;
esac