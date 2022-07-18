# aws-toolz-containers

Assembly of AWS Tools for DevSecOps

## Tools (WIP)

* [AWS CLI](https://aws.amazon.com/cli/) – The AWS CLI is a powerful tool that lets perform most of the actions that you can do via the AWS Console.
* [AWS Vault](https://github.com/99designs/aws-vault#installing) – AWS Vault is a slick tool that allows you to easily use different sets of AWS credentials to run commands (`aws`, `terragrunt`, `packer`, et cetera). Once you've gone beyond a single AWS account, a tool like AWS vault is immensely helpful.
* [Docker](https://www.docker.com/get-started) – Run applications in a container that contains everything needed to run the application without affecting the host environment.
* [Golang](https://go.dev/dl/) – Golang is an exciting language that has taken the DevOps / infrastructure world by storm. Terraform, Terragrunt, and Terratest are all written in Go.
* [Kubectl](https://kubernetes.io/docs/tasks/tools/) – If you need to control your Kubernetes cluster, `kubectl` is at the operational core.
* [Packer](https://www.packer.io/downloads) – Packer lets you build a variety of images, including AWS AMIs and Docker containers. Those images are defined via code for repeatability.
* [Terraform](https://www.terraform.io/downloads) – Terraform's declarative nature describes your infrastructure as code. If you're using Gruntwork's products, you're using Terraform.
* [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) – Terragrunt is our layer on top of Terraform to enable a highly DRY code base.
* [Terratest](https://github.com/gruntwork-io/terratest) – If you want to test your infrastructure, Terratest enables you to write those tests for manual testing or integration with a CI/CD pipeline.
* [tfenv](https://github.com/tfutils/tfenv#installation) – `tfenv` is a set of bash scripts that provide a workflow for managing and using multiple versions of Terraform. It was inspired by similar tools `rbenv` for Ruby versions and `pyenv` for Python.
* [tgswitch](https://github.com/warrensbox/tgswitch#installation) – `tgswitch` is a tool for managing and using multiple versions of Terragrunt. Written in golang, it offers similar features as `tfenv`, including managing the versions to use in a version file.