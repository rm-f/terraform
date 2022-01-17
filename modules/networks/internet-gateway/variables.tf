variable "vpc_name" {
  description = "vpc name" 
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
