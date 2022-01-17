variable "subnet_name" {
  description = "subnet name" 
  type = string
}

variable "internet_gateway_name" {
  description = "internet gateway name" 
  type = string
}

variable "nat_gateway_name" {
  description = "nat gateway name" 
  type = string
}

variable "connectivity_type" {
  description = "connectivity_type public / private" 
  type = string
}

variable "gateway_tags" {
  description = "gateway tags" 
  type = map(string)
}
