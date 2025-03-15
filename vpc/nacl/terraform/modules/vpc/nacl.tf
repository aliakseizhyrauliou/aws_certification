resource "aws_network_acl" "this" {
  vpc_id = aws_vpc.this.id

  ingress {
    protocol   = "tcp"       
    rule_no    = 100         
    action     = "allow"     
    cidr_block = "0.0.0.0/0"
    from_port  = 80          
    to_port    = 80          
  }

  egress {
    protocol   = "-1"        
    rule_no    = 100         
    action     = "allow"     
    cidr_block = "0.0.0.0/0" 
    from_port  = 0           
    to_port    = 0           
  }

  tags = {
    Name = format("nacl-%s", var.project_name)
  }
}

resource "aws_network_acl_association" "association" {
  network_acl_id = aws_network_acl.this.id
  subnet_id      = aws_subnet.this.id
}