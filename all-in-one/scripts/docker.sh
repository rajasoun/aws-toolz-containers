#!/usr/bin/env 


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
    echo "Launching ci-shell for $CONTAINER_NAME:$VERSION"
    # shellcheck disable=SC2140
    _docker run --rm -it \
            -h "dev-toolz-$SHELL_NAME-shell" \
            -e "USER_NAME=\"$USER_NAME"\" \
            -e "USER_EMAIL=$USER_EMAIL" \
            --name "dev-toolz-$SHELL_NAME" \
            --sig-proxy=false \
            -a STDOUT -a STDERR \
            --entrypoint=$ENTRY_POINT_CMD \
            --user vscode  \
            --mount source="${PWD}/.config/dotfiles/.gitconfig",target="/home/vscode/.gitconfig",type=bind,consistency=cached \
            --mount source="${PWD}/.config/.ssh",target="/home/vscode/.ssh",type=bind,consistency=cached \
            --mount source="${PWD}/.config/.sso",target="/home/vscode/.duo-sso",type=bind,consistency=cached \
            --mount source="${PWD}/.config/.kube",target="/home/vscode/.kube",type=bind,consistency=cached \
            --mount source="${PWD}/.config/.gpg2/keys",target="/home/vscode/.gnupg",type=bind,consistency=cached \
            --mount source="${PWD}/.config/.store",target="/home/vscode/.password-store",type=bind,consistency=cached \
            --mount source="${PWD}/.config/.aws",target="/home/vscode/.aws",type=bind,consistency=cached \
            --mount source="${PWD}",target="/workspaces/$GIT_REPO_NAME",type=bind,consistency=cached \
            --mount src=vscode,dst=/vscode -l vsch.local.folder="${PWD}",type=volume \
            -l vsch.quality=stable -l vsch.remote.devPort=0 \
            -w "/workspaces/$GIT_REPO_NAME" \
            "$CONTAINER_NAME:$VERSION"
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

function docker_main(){
    export SHELL_NAME=${3:-'aws'}
    ENV=${2:-'dev'}
    ENTRY_POINT_CMxD=${3:-'/bin/zsh'}

    # VERSION=$(git describe --tags --abbrev=0 | sed -Ee 's/^v|-.*//')
    export CONTAINER_NAME="rajasoun/dev-toolz-$SHELL_NAME-all-in-one"
    export VERSION=1.0.0

    setup $ENV
    launch $ENTRY_POINT_CMD
}



# Wrapper To Aid TDD
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  if ! docker_main "$@"; then
    exit 1
  fi
fi