BOLD :=$(shell tput bold)
RED :=$(shell tput setaf 1)
GREEN :=$(shell tput setaf 2)
YELLOW :=$(shell tput setaf 3)
RESET :=$(shell tput sgr0)

NAME := $(shell basename $(PWD) | sed 's/\.//g')
LIST_TAGS := $(shell git tag -l)
IMAGE_NAME=rajasoun/dev-toolz-$(NAME)
#VERSION := $(shell [ "${LIST_TAGS}" ] && echo "$(shell git describe --tags --abbrev=0)" ||  echo 1.0.0 )
BASE_PATH=$(shell git rev-parse --show-toplevel)
BASE_IMAGE=$(shell cat $(BASE_PATH)/.ci/base_image.txt)
VERSION=$(shell cat $(BASE_PATH)/.ci/version.txt)

CONTEXT="."

DOCKER_REGISTRY_TOKEN="$(BASE_PATH)/.dockerhub.token"

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container

tools-prerequisite: ## Pre-Requisite Checks for build & push
	@echo "$(GREEN)\nTools PreRequisite Checks $(RESET)"
	@code --version >/dev/null 2>&1 && (echo "✅ Visual Studio Code") || (echo  "❌ Visual Studio Code")
	@make --version >/dev/null 2>&1 && (echo "✅ make") || (echo  "❌ make")
	@docker --version >/dev/null 2>&1 && (echo "✅ Docker") || (echo  "❌ Docker")
	@echo ""

config-prerequisite: ## Pre-Requisite Checks for Configs
	@echo "$(GREEN)\nConfigs PreRequisite Checks $(RESET)"
	@ls -asl .config/dotfiles/.gitconfig >/dev/null 2>&1 && (echo "✅ .gitconfig File. Using Command -> generate_git_config") || (echo  "❌ .gitconfig File. Execute -> generate_git_config")
	@ls -asl .config/.ssh/*id_rsa* >/dev/null 2>&1 && (echo "✅ .ssh keys. Using Command -> gssh_config") || (echo  "❌ .ssh keys. Execute -> gssh_config")
	@ls -asl .config/.gpg2/keys/private.key >/dev/null 2>&1 && (echo "✅ gpg2 config. Using Command -> generate_gpg_keys") || (echo  "❌ gpg2 config. Execute -> generate_gpg_keys")
	@ls -asl .config/.store/.gpg-id >/dev/null 2>&1 && (echo "✅ password-store config. Using Command ->  init_pass_store") || (echo  "❌ password-store config. Execute -> init_pass_store")
	@ls -asl .config/.aws/config >/dev/null 2>&1 && (echo "✅ aws config. Using Command -> aws-env") || (echo  "❌ aws config. Execute -> aws-env")
	@echo ""

login: ## Login To Docker
	@echo "$(BOLD)$(YELLOW) Login to Docker Registry $(RESET)"
	cat $(DOCKER_REGISTRY_TOKEN) | docker login --username rajasoun --password-stdin
	@echo "$(BOLD)$(GREEN)Completed Login to Docker Registry $(RESET)"

version:
	@echo "Current Version : "$(VERSION)
	$(eval VERSION=$(shell echo $(VERSION) | awk -F. '{OFS="."; $$NF+=1; print $0}'))
	@echo "Version to be Bumped: "$(VERSION)

# Pre-Requisites:
#	1. One Time - Create Manual Release :ToDo - To be Automated
#	2. Edit devcontainer.json - UnComment line 7 & Comment line 9 & 10
build:  ## Build the container - Copy of Visual Studio Code Container
	@echo "$(BOLD)$(YELLOW)Building docker image - $(IMAGE_NAME):$(VERSION) $(RESET)"
	docker build -t $(IMAGE_NAME):$(VERSION) \
			--build-arg BASE_IMAGE=$(BASE_IMAGE) \
			--build-arg VERSION=$(VERSION)  \
			$(CONTEXT)
	@echo "$(BOLD)$(GREEN)Completed building docker image - $(IMAGE_NAME):$(VERSION) $(RESET)"

push: login ## Push to Docker Hub
	@echo "$(BOLD)$(YELLOW) Push to Docker Registry $(RESET)"
	docker push $(IMAGE_NAME):$(VERSION)
	@echo "$(BOLD)$(GREEN)Completed Push to Docker Registry for $(IMAGE_NAME):$(VERSION) $(RESET)"

clean: ## Remove Base Container Image
	@echo "$(BOLD)$(YELLOW)Removing docker image locally - $(IMAGE_NAME):$(VERSION) $(RESET)"
	docker rmi --force $(IMAGE_NAME):$(VERSION)
	@echo "$(BOLD)$(GREEN)Completed removing docker image - $(IMAGE_NAME) $(RESET)"

test: ## Automated e2e Test Suite for devcontainer
	@echo "$(BOLD)$(YELLOW) DevContainer e2e Tests $(RESET)"
	all-in-one/dev-toolz.sh "ops" "/workspaces/tests/system/e2e_tests.sh" "e2e-test"
	@echo "$(BOLD)$(GREEN)Completed DevContainer e2e Tests $(RESET)"

all:  prerequisite build login push clean ## All in One Command - (prerequisite git build login push clean)
