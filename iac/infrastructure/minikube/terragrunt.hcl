terraform {
  source = "iac/terraform/blueprints/minikube"
}

inputs = {
  driver = "docker"
}