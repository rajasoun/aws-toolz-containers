#!/usr/bin/env bash

NC=$'\e[0m' # No Color
BOLD=$'\033[1m'
UNDERLINE=$'\033[4m'
RED=$'\e[31m'
GREEN=$'\e[32m'
BLUE=$'\e[34m'
ORANGE=$'\x1B[33m'

BASE_PATH="$(git rev-parse --show-toplevel)"
MAKEFILE_PATH="$BASE_PATH/.ci/Makefile"


function execute_action(){
    action=$1
    directory=$2
    if [ ! -z $directory  ];then
        cd $directory && make -f $MAKEFILE_PATH $action && cd -
        echo -e "${GREEN}Action $action for $directory successfull${NC}\n"
        return 0
    fi
    # Base First
    cd base && make -f $MAKEFILE_PATH $action && cd -
    echo -e "${GREEN}Action $action for base successfull${NC}\n"

    for directory in ./* # iterate over all files in current dir
    do
        if [[ -d "$directory" && $directory != "./assembly" && $directory != "./all-in-one" ]];then
            cd $directory && make -f $MAKEFILE_PATH $action && cd - 
            echo -e "${GREEN}Action $action for $directory successfull${NC}\n"
        fi
    done
    echo -e "${GREEN}Action $action on All Containers successfull${NC}\n"
    # assembly and all-in-one last
    cd "$BASE_PATH/assembly"   && make -f $MAKEFILE_PATH $action && cd -
    echo -e "${GREEN}Action $action for assembly successfull${NC}\n"
    cd "$BASE_PATH/all-in-one" && make -f $MAKEFILE_PATH $action && cd -
    echo -e "${GREEN}Action $action for all-in-one successfull${NC}\n"
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
    USER_NAME="$(git config user.name)"
    USER_EMAIL="$(git config user.email)"
    docker run --rm -it \
        --entrypoint=/bin/zsh \
        -e "USER_NAME=\"$USER_NAME"\" \
        -e "USER_EMAIL=$USER_EMAIL" \
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
        if [ ! -z $dir_path  ];then
            clean  $dir_path
        else 
            docker rmi $(docker images -a --filter=reference="rajasoun/aws-toolz-*" -q)
            echo -e "${GREEN}Action $action for all imagessuccessfull${NC}\n"
        fi        
    ;;
    "run")
        run  $dir_path
    ;;
    "e2e-test")
        make -f .ci/Makefile test
    ;;
    "git-login")
        gh auth login --hostname $GIT --git-protocol ssh --with-token < github.token
        gh auth status
        ssh -T git@github.com
    ;;
    "aws-toolz ")
        all-in-one/aws-toolz.sh dev
    ;;
    *)
    echo "${RED}Usage: assist.sh < build | push | clean > [dir_path] ${NC}"
    echo "${ORANGE}When dir_path is not povided actions runs on all dirs${NC}"
cat <<-EOF

Commands:
---------
  build                 -> Build all Containers
  push                  -> Push all Containers
  clean                 -> Clean all Containers
  run                   -> Run container based on directory path
  e2e-test              -> Run e2e Tests on the Devcontainer
  git-login             -> Git Login
  aws-toolz             -> Launch all-in-one shell 
EOF
    ;;
esac
