#!/usr/bin/env bash

BASE_DIR="$(git rev-parse --show-toplevel)"

# shellcheck source=/dev/null
source "$BASE_DIR/workspace-scripts/automator/libs/os.sh"
# shellcheck source=/dev/null
source "$BASE_DIR/all-in-one/scripts/docker.sh"

# VERSION=$(git describe --tags --abbrev=0 | sed -Ee 's/^v|-.*//')
export CONTAINER_NAME="rajasoun/dev-toolz-all-in-one"
export VERSION=1.0.0

export USER_NAME="$(git config user.name)"
export USER_EMAIL="$(git config user.email)"


docker_main $@
