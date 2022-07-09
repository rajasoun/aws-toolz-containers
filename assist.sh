#!/usr/bin/env bash 

NC=$'\e[0m' # No Color
BOLD=$'\033[1m'
UNDERLINE=$'\033[4m'
RED=$'\e[31m'
GREEN=$'\e[32m'
BLUE=$'\e[34m'
ORANGE=$'\x1B[33m'

MAKEFILE_PATH="$(git rev-parse --show-toplevel)/.ci/Makefile"


function execute_action(){
    action=$1
    directory=$2
    if [ ! -z $directory  ];then 
        cd $directory && make -f $MAKEFILE_PATH $action && cd -
        echo -e "${GREEN}Action $action on Container $directory successfull${NC}\n"
        return 0
    fi 
    # Build Base First
    cd base && make -f $MAKEFILE_PATH $action && cd -
    for directory in ./* # iterate over all files in current dir
    do
        if [ -d "$directory" ] # if it's a directory
        then
            cd $directory && make -f $MAKEFILE_PATH $action && cd -
        fi
    done 
    echo -e "${GREEN}Action $action on All Containers successfull${NC}\n"
}

function build(){
    directory=$1
    execute_action build $directory
}

function push(){
    directory=$1
    execute_action push $directory
}

function clean(){
    directory=$1
    execute_action clean $directory
}

function run(){
    directory=$1
    directory=$(echo $directory | sed 's/\.//g')
    docker run --rm -it \
        --entrypoint=/bin/zsh \
        rajasoun/aws-toolz-$directory:1.0.0
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
    "run")
        run  $dir_path
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
  run         -> Run container based on directory path
  
EOF
    ;;
esac