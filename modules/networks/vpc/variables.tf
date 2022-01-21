variable "vpc_name" {
  description = "vpc name" 
  type = string
}

variable "enable_dns_hostnames" {
  description = "enable dns hostnames" 
  type = bool
}

variable "vpc_cidr_block" {
  description = "vpc cidr block" 
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_instance_tenancy" {
  description = "instance tenancy" 
  type = string
  default = "default"
}

variable "vpc_tags" {
  description = "vpc tags" 
  type = map(string)
}

