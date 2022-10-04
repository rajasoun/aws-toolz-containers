#!/usr/bin/env bash

BASE_DIR="$(git rev-parse --show-toplevel)"
SCRIPT_PATH="$BASE_DIR/workspace-scripts/automator/libs/os.sh"
# shellcheck source=/dev/null
source "$SCRIPT_PATH"

# VERSION=$(git describe --tags --abbrev=0 | sed -Ee 's/^v|-.*//')
export name="rajasoun/aws-toolz-all-in-one"
export VERSION=1.0.0

# Workaround for Path Limitations in Windows
function _docker() {
  export MSYS_NO_PATHCONV=1
  export MSYS2_ARG_CONV_EXCL='*'

  case "$OSTYPE" in
      *msys*|*cygwin*) os="$(uname -o)" ;;
      *) os="$(uname)";;
  esac

  if [[ "$os" == "Msys" ]] || [[ "$os" == "Cygwin" ]]; then
      # shellcheck disable=SC2230
      realdocker="$(which -a docker | grep -v "$(readlink -f "$0")" | head -1)"
      printf "%s\0" "$@" > /tmp/args.txt
      # --tty or -t requires winpty
      if grep -ZE '^--tty|^-[^-].*t|^-t.*' /tmp/args.txt; then
          #exec winpty /bin/bash -c "xargs -0a /tmp/args.txt '$realdocker'"
          winpty /bin/bash -c "xargs -0a /tmp/args.txt '$realdocker'"
          return 0
      fi
  fi
  docker "$@"
  return 0
}

function launch(){
    ENTRY_POINT_CMD=$1
    GIT_REPO_NAME="$(basename "$(git rev-parse --show-toplevel)")"
    echo "Launching ci-shell for $name:$VERSION"
    # shellcheck disable=SC2140
    _docker run --rm -it \
            -h "toolz-shell" \
            -e "USER_NAME=\"$USER_NAME"\" \
            -e "USER_EMAIL=$USER_EMAIL" \
            --name "toolz-shell-$GIT_REPO_NAME" \
            --sig-proxy=false \
            -a STDOUT -a STDERR \
            --entrypoint=$ENTRY_POINT_CMD \
            --user vscode  \
            --mount type=bind,source="${PWD}/.config/dotfiles/.gitconfig",target="/home/vscode/.gitconfig",consistency=cached \
            --mount type=bind,source="${PWD}/.config/.ssh",target="/home/vscode/.ssh",consistency=cached \
            --mount type=bind,source="${PWD}/.config/.gpg2/keys",target="/home/vscode/.gnupg",consistency=cached \
            --mount type=bind,source="${PWD}/.config/.store",target="/home/vscode/.password-store",consistency=cached \
            --mount type=bind,source="${PWD}/.config/.aws",target="/home/vscode/.aws",consistency=cached \
            --mount type=bind,source="${PWD}",target="/workspaces/$GIT_REPO_NAME",consistency=cached \
            --mount type=volume,src=vscode,dst=/vscode -l vsch.local.folder="${PWD}" \
            -l vsch.quality=stable -l vsch.remote.devPort=0 \
            -w "/workspaces/$GIT_REPO_NAME" \
            "$name:$VERSION"
}

function setup(){
    ENV=$1
    if [ "$ENV" = "dev" ]; then
        echo "$(date)" > "$(git rev-parse --show-toplevel)/.dev"
        echo -e "\n${BOLD}${UNDERLINE}CI Shell For Dev${NC}"
        rm -fr "$(date)" > "$(git rev-parse --show-toplevel)/.ops"
    else
        echo -e "\n${BOLD}${UNDERLINE}CI Shell For Ops${NC}"
    fi
    if [ -z $ENTRY_POINT_CMD ]; then
        ENTRY_POINT_CMD="/bin/zsh"
    fi
}

function main(){
    ENV=$1
    ENTRY_POINT_CMD=$2

    setup $ENV
    launch $ENTRY_POINT_CMD
}

main $@
