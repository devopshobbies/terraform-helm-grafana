terraform {
  required_providers {
    helm = {
      version = "~> 2.5.1"
    }
    kubernetes = {
      version = "~> 2.11.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
