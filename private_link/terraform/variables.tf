variable "vpc_config" {
    type = object({
        cidr_block = string
    })
}

variable "public_subnet_config" {
    type = object({
        cidr_block = string
    })
}

variable "private_subnet_config" {
  type = object({
    cidr_block = string 
  })
}

variable "region" {
  type = string
}