variable "vpc_config" {
  type = object({
    vpc_name = string
    vpc_cidr = string
    public_subnet_cidr = string
    private_subnet_cidr = string
  })
}