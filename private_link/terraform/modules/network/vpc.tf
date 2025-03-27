locals {
  anywhere = "0.0.0.0/0"
}

resource "aws_vpc_ipam" "ipam" {
  operating_regions {
    region_name = var.region
  }
}

resource "aws_vpc_ipam_pool" "test" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.ipam.private_default_scope_id
  locale         = var.region
}

resource "aws_vpc_ipam_pool_cidr" "test" {
  ipam_pool_id = aws_vpc_ipam_pool.test.id
  cidr         = var.vpc_cidr_block
}

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
        Name = format("vpc-%s", var.project_name)
    }
}


resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr_block

    tags = {
      Name = format("public-subnet-%s", var.project_name)
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr_block

    tags = {
      Name = format("private-subnet-%s", var.project_name)
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("igw-%s", var.project_name)
  }
}

resource "aws_route_table" "public_subnet_route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = local.anywhere
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = format("public-subnet-rt-%s", var.project_name)
    }
}


resource "aws_route_table_association" "public_igw_association" { 
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_subnet_route_table.id
}



resource "aws_route_table" "private_subnet_route_table" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = format("private-subnet-rt-%s", var.project_name)
    }
}


resource "aws_route_table_association" "private__association" { 
    subnet_id      = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_subnet_route_table.id
}
