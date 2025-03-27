output "private_sg" {
  value = aws_security_group.private_host.id
}

output "bastion_sg" {
  value = aws_security_group.bastion_host.id
}