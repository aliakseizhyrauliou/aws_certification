locals {
  anywhere = "0.0.0.0/0"
}

resource "aws_vpc" "bastion-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {

  vpc_id     = aws_vpc.bastion-vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "bastion_public_subnet"
  }
}

resource "aws_subnet" "private" {

  vpc_id     = aws_vpc.bastion-vpc.id
  cidr_block = var.private_subnet_cidr
    
  tags = {
    Name = "bastion_private_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.bastion-vpc.id

  tags = {
    Name = "public_subnet_igw"
  }
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.bastion-vpc.id

  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_subnet_rt"
  }
}

resource "aws_route_table_association" "associate_public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}