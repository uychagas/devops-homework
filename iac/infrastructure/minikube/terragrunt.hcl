terraform {
  source = "../../terraform/blueprints/minikube"
}

inputs = {
  driver = "docker"
}