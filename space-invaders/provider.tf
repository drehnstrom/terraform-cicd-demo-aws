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
      region = "us-east-1"
    }
}

provider "aws" {
  region = var.region
}
