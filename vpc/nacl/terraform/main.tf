locals {
  region = "us-east-2"
  project_name = "bash"
}


module "vpc" {
  source = "./modules/vpc"
  project_name = locals.project_name
  vpc_cidr = "10.0.0.0/16"
  subnet_cidr = "10.0.0.0/20"
}