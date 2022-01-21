variable "igw_route_table_name" {
  description = "internet gateway route table name" 
  type = string
}

variable "nat_route_table_name" {
  description = "nat gateway route table name" 
  type = string
}

variable "vpc_id" {
  description = "vpc id" 
  type = string
}

variable "igw_subnet_id" {
  description = "internet gateway subnet id" 
  type = string
}

variable "natgw_subnet_id" {
  description = "nat gateway id" 
  type = string
}

variable "cidr_block" {
  description = "cidr block"
  type = string
}

variable "internet_gateway_ids" {
  description = "internet gateway id list" 
  type = list(string)
}

variable "nat_gateway_ids" {
  description = "nat gateway id list" 
  type = list(string)
}

variable "route_table_tags" {
  description = "route table tags" 
  type = map(string)
}

