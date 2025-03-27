locals {
  project_name = "private-link-learn"
}

module "vpc" {
  source = "./modules/network"
  vpc_cidr_block = var.vpc_config.cidr_block
  project_name = local.project_name

  region = var.region
  private_subnet_cidr_block = var.private_subnet_config.cidr_block
  public_subnet_cidr_block = var.public_subnet_config.cidr_block
}

module "s3" {
  source = "./modules/s3"
  project_name = local.project_name
}

module "securiy_groups" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  private_host_sg_id = module.securiy_groups.private_sg
  public_host_sg_id = module.securiy_groups.bastion_sg
}

