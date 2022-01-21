variable "vpc_id" {
  description = "vpc id" 
  type = string
}

variable "gateway_name" {
  description = "internet gateway name" 
  type = string
}

variable "gateway_tags" {
  description = "gateway tags" 
  type = map(string)
}
