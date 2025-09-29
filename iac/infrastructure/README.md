# Infrastructure (iac/infrastructure)

This folder contains Terragrunt wrappers that deploy the local development infrastructure for the project:
- a local Minikube cluster
- the Rails application deployed into that cluster


## Directory layout
- app/ — Terragrunt configuration that builds the Docker image and deploys the Helm chart into the Minikube cluster.
- minikube/ — Terragrunt configuration that installs/starts Minikube and prepares the host (tunnel, /etc/hosts entry, Docker env).

## Prerequisites
- Linux or macOS
- Docker installed and running
- Terragrunt and Terraform (versions documented in the project README)
- kubectl, minikube, and Helm
- Your user must be able to run sudo for a few provisioning steps (installing the minikube binary, editing /etc/hosts, and running the minikube tunnel). See notes below for safer options.