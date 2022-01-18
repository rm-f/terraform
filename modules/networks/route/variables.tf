variable "route_table" {
  description = "route table name"
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