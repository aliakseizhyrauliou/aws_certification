resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr
  tags = {
    Name = format("vpc-%s", var.project_name)
  }
}