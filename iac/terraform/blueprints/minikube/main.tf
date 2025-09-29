terraform {
  required_version = ">= 1.12.0"
}

resource "null_resource" "install_minikube" {
  provisioner "local-exec" {
    command     = <<EOT
      # Detect OS
      unameOut="$(uname -s 2>/dev/null || echo Unknown)"
      case "$unameOut" in
        Linux*)   os=linux;;
        Darwin*)  os=darwin;;
        *)        os="unknown";;
      esac

      # Detect Architecture
      archOut="$(uname -m 2>/dev/null || echo Unknown)"
      case "$archOut" in
        x86_64|amd64)   arch=amd64;;
        arm64|aarch64)  arch=arm64;;
        armv7l|arm)     arch=arm;;
        *)              arch="unknown";;
      esac

      if [ "$os" = "unknown" ] || [ "$arch" = "unknown" ]; then
        echo "Unsupported OS or architecture: $os-$arch"
        exit 1
      fi

      file="minikube-$os-$arch"
      dest="minikube"

      url="https://storage.googleapis.com/minikube/releases/latest/$file"
      echo "Downloading Minikube from: $url"
      curl -s "$url" -o $dest

      chmod +x "$dest"
      sudo mv "$dest" /usr/local/bin/
    EOT
    interpreter = ["bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "minikube stop && minikube delete"
    interpreter = ["bash", "-c"]
  }
}

resource "null_resource" "minikube_start" {
  provisioner "local-exec" {
    command     = <<EOT
      #!/usr/bin/env bash
      set -e
      if ! command -v minikube >/dev/null 2>&1; then
        echo "minikube is not installed. Please install it first."
        exit 1
      fi
      if ! minikube status | grep -q "host: Running"; then
        minikube start --driver=${var.driver}
      else
        echo "Minikube is already running."
      fi

      minikube addons enable ingress
      eval $(minikube docker-env)
      nohup sudo minikube tunnel > minikube-tunnel.log 2>&1 &
      echo "127.0.0.1 minikube.localhost" | sudo tee -a /etc/hosts

    EOT
    interpreter = ["bash", "-c"]
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<EOT
      #!/usr/bin/env bash
      set -e
      sudo sed -i.bak '/127\.0\.0\.1 minikube\.localhost/d' /etc/hosts
    EOT
    interpreter = ["bash", "-c"]
  }

  depends_on = [null_resource.install_minikube]
}

