terraform {
  required_version = ">= 0.12, < 0.13"

  required_providers {
    aws = "~> 2.7"
  }

}

provider "aws" {
  region                  = var.region
  shared_credentials_file = var.aws_credentials_path
}
