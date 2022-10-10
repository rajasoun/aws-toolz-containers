#!/usr/bin/env bash

BASE_DIR="$(git rev-parse --show-toplevel)"

# shellcheck source=/dev/null
# source "$BASE_DIR/workspace-scripts/automator/libs/os.sh"

# shellcheck source=/dev/null
source "$BASE_DIR/all-in-one/scripts/docker.sh"

export USER_NAME="$(git config user.name)"
export USER_EMAIL="$(git config user.email)"


docker_main $@
