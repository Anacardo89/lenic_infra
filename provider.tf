terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.3"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_terraform_key
  secret_key = var.aws_terraform_secret
}