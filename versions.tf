terraform {
  required_providers {
    helm = {
      version = "~> 2.4.1"
    }
    kubernetes = {
      version = "~> 2.8.0"
    }
    aws = {
      version = "~> 3.0.0"
    }
  }
}