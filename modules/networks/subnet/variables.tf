# variable "vpc_name" {
#   description = "vpc name" 
#   type = string
# }

variable "vpc_id" {
  description = "vpc id" 
  type = string
}

variable "subnet_name" {
  description = "subnet name" 
  type = string
}

variable "subnet_cidr_block" {
  description = "subnet cidr block" 
  type = string
}

variable "subnet_tags" {
  description = "subnet tags" 
  type = map(string)
}
 
variable "subnet_availability_zone" {
  description = "subnet availability zone"
  type = string
}

variable "subnet_map_public_ip_on_launch" {
  description = "subnet map public ip"
  type = bool
  default = false
}

