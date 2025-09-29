# devops-homework

This repository contains a `Hello World` Rails application, a Helm chart, and Terraform/Terragrunt infrastructure
blueprints
to run the app locally on Minikube.

## Contents

| Directory                | Description                     |
|--------------------------|---------------------------------|
| helm-chart               | Helm chart for the Rails app    |
| iac/terraform/blueprints | Terraform blueprints            |
| iac/infrastructure       | Infrastructure Terragrunt files |
| rails-app                | Rails application               |

## Requirements
Minimum tested versions:

| Name       | Version       |
|------------|---------------|
| OS         | Linux / MacOS |
| Docker     | 27.5.1        |
| Terraform  | 1.13.3        |
| Terragrunt | 0.88.0        |
| Helm       | 3.19.0        |
| Kubectl    | 1.30.2        |
| Ruby       | 3.4.4         |
| Rails      | 8.0.3         |

## Quick start
*ATTENTION*: This is a quick start guide and all commands should be run from the root of the project.

### Infra deploy
It creates a local Minikube cluster and deploys the app to it.

```bash
terragrunt apply --config iac/infrastructure/minikube/terragrunt.hcl
```

### App deploy
It deploys the rails app to the local Minikube cluster.
```bash
eval $(minikube docker-env); terragrunt apply --config iac/infrastructure/app/terragrunt.hcl
```

### Infra destroy
It deletes the local Minikube cluster.
```bash
terragrunt destroy --config iac/infrastructure/minikube/terragrunt.hcl
```

---
1. How would you manage your terraform state file for multiple environments?
   - Use a remote, durable, and lockable backend (e.g., S3 + DynamoDB for AWS) for all state files.
   - Keep one state per logical environment and per independently-deployable component.
   - Use directory-per-environment (or Terragrunt-generated paths) to isolate states.
   - Enforce locking, encryption, access controls, and automated backups.
   - Integrate state management into CI/CD and include migration/playbooks for state changes.
----
2. How would you approach managing terraform variables and secrets as well?
   - Treat Terraform state and variable files as sensitive — do not store secrets in plaintext in the repo.
   - Keep non-sensitive variables in VCS with clear env scoping; keep secrets encrypted or in a secrets manager.
   - Use environment-specific configuration (per-env Terragrunt/inputs) rather than overloading workspaces.
   - Inject secrets at runtime (CI/CD or provider) rather than baking them into generated manifests when possible.
----
3. Describe how you would test this infrastructure.
   1. Static analysis & linting
       - terraform fmt, terragrunt hclfmt for style.
       - terraform validate / terragrunt validate-all for config sanity.
       - tflint for provider/pattern issues.
       - helm lint and chart-testing for Helm chart correctness.

   2. Unit-like tests
      - Module tests with Terratest (assert resource count, names, attributes).
      - Helm template tests (helm unittest or chart-testing) to validate rendered manifests against expectations.

   3. Plan-time policy & checks
      - CI runs terragrunt plan per-PR; fail on unexpected changes. (Atlantis)
      - Enforce policy-as-code (OPA/Rego, Sentinel) to block disallowed changes (public IPs, missing tags, cost limits).
      - Parse plan for sensitive or destructive actions and require approvals if detected.

   4. Chaos & resilience tests
       - Controlled failures in staging: kill pods, simulate node loss, rotate secrets.
       - Validate self-healing, readiness/liveness probe behavior, and secret rotation handling.
