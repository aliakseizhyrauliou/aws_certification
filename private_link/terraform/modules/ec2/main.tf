
locals {
  ami = "ami-0d0f28110d16ee7d6"
  instance_type = "t2.nano"
  key_name = "my_key"
}

data "aws_key_pair" "my_key" {
  key_name           = local.key_name
}

resource "aws_instance" "bastion" {
  ami           = local.ami
  instance_type = local.instance_type
  subnet_id     = var.public_subnet_id
  associate_public_ip_address = true
  security_groups = [var.public_host_sg_id]
  tags = {
    Name = "bastion_host"
  }
}

resource "aws_instance" "private_instance" {
  ami         = local.ami
  instance_type = local.instance_type
  subnet_id     = var.private_subnet_id
  security_groups = [var.private_host_sg_id]
  key_name  = data.aws_key_pair.my_key.key_name

  tags = {
    Name = "private_instance"
  }
}