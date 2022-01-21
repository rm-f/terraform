variable "route_table_id" {
  description = "route table id"
  type = string
}

variable "cidr_block" {
  description = "cidr block"
}

variable "internet_gateway_ids" {
  description = "internet gateway id list" 
  type = list(string)
}

variable "nat_gateway_ids" {
  description = "nat gateway id list" 
  type = list(string)
}