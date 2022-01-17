variable "route_table_name" {
  description = "route table name" 
  type = string
}

variable "vpc_name" {
  description = "vpc name" 
  type = string
}

variable "igw_subnet_name" {
  description = "internet gateway subnet name" 
  type = string
}

variable "natgw_subnet_name" {
  description = "nat gateway subnet" 
  type = string
}

variable "cidr_block" {
  description = "cidr block"
}

variable "internet_gateway_names" {
  description = "internet gateway name" 
  type = list(string)
}

variable "nat_gateway_names" {
  description = "nat gateway name" 
  type = list(string)
}

variable "route_table_tags" {
  description = "route table tags" 
  type = map(string)
}

