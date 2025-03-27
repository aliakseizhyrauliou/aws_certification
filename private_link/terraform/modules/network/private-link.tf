locals {
  s3_service_name = "com.amazonaws.us-east-2.s3"
  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.vpc.id
  service_name = local.s3_service_name
  vpc_endpoint_type = local.vpc_endpoint_type
  route_table_ids   = [aws_route_table.private_subnet_route_table.id]
  tags = {
    Name = format("s3-endpoint-%s", var.project_name)
  }
}