terraform {
  required_version = ">= 1.12.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.1"
    }
  }
}

provider "docker" {}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}

resource "null_resource" "rails_app_hash" {
  triggers = {
    app_hash = trim(
      chomp(
        join(
          "",
          [
            for f in fileset("${path.root}/rails-app", "**") :
            filemd5("${path.root}/rails-app/${f}")
          ]
        )
      ),
      "\n"
    )
  }
}

resource "docker_image" "app_image" {
  name = "${var.app_name}:latest"
  build {
    context    = "${path.root}/${var.app_name}"
    dockerfile = "Dockerfile"
    build_args = {
      FOLDER_HASH = null_resource.rails_app_hash.triggers.app_hash
    }
  }
  force_remove = true
  depends_on   = [null_resource.rails_app_hash]
}

resource "helm_release" "application" {
  name      = var.app_name
  namespace = var.namespace_name
  chart     = "${path.root}/helm-chart"
  values = [
    file("${path.root}/${var.app_name}/k8s/values.yaml")
  ]
  create_namespace = true
  atomic           = true

  set = [
    {
      name  = "railsAppHash"
      value = null_resource.rails_app_hash.triggers.app_hash
    }
  ]

  depends_on = [
    docker_image.app_image,
    null_resource.rails_app_hash
  ]
}
