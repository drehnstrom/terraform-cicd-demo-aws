terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
      bucket = "doug-terraform-remote-state"
      key    = "terraform-cicd-demo-aws"
      region = var.region
    }
}

provider "aws" {
  region = var.region
}
