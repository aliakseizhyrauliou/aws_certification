terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.80.1"
    }
  }
}

provider "aws" {
  # Configuration options
}   