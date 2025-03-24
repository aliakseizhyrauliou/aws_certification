module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_config.vpc_name
  vpc_cidr = var.vpc_config.vpc_cidr
  public_subnet_cidr = var.vpc_config.public_subnet_cidr
  private_subnet_cidr = var.vpc_config.private_subnet_cidr
}

module "securiy_groups" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  public_subnet_cidr = var.vpc_config.public_subnet_cidr
  private_subnet_cidr = var.vpc_config.private_subnet_cidr
}

module "ec2" {
  source = "./modules/ec2"
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  private_host_sg_id = module.securiy_groups.private_sg
  public_host_sg_id = module.securiy_groups.bastion_sg
}