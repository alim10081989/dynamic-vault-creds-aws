terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.2.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.3.0"
    }
  }
}
