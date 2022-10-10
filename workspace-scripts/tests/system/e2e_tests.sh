#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/test-utils.sh"

# Run common tests
checkCommon

# Definition specific tests
#checkExtension "ms-azuretools.vscode-docker"

check "gh" gh --version
check "fetch" fetch --version

check "pre-commit" pre-commit --version
check "dotenv" dotenv --version

check "aws" aws --version
check "awless" awless --version

check "aws-sso" aws-sso -version
check "gpg2" gpg2 --version
check "pass" pass --version
check "aws-vault" aws-vault --version

check "aws-crawl" aws-crawl version
check "awsaudit" awsaudit --version
check "cloudsplaining" cloudsplaining --version

check "syft" syft --version
check "grype" grype version

check "cloud-nuke" cloud-nuke --version
check "aws-nuke" aws-nuke version

check "packer" packer version
check "terraform" terraform version
check "terragrunt" terragrunt --version

check "aws-iam-authenticator" aws-iam-authenticator version
check "kubectl" kubectl version  --client --output=yaml
check "eksctl" eksctl version
check "helm" helm version

check "pulumi" pulumi version
check "sentry-cli" sentry-cli --version
check "http" http --version

#check "pre-commit" pre-commit run --all-files
# Report result
reportResults

EXIT_CODE="$?"
log_sentry "$EXIT_CODE" "e2e_tests.sh "
