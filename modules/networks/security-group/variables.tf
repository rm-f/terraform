variable "name" {
  type = string
  description = "security group name"
}

variable "description" {
  type = string
  description = "security group description"
}

variable "vpc_id" {
  type = string
  description = "vpc id"
}

variable "ingress_description" {
  type = string
  description = "ingress description"
}

variable "ingress_from_port" {
  type = number
  description = "ingress from port"
}

variable "ingress_to_port" {
  type = number
  description = "ingress to port"
}

variable "ingress_protocol" {
  type = string
  description = "ingress protocol TCP, -1(all)"
}

variable "ingress_cidr_blocks" {
  type = list(string)
  description = "ingress cidr block list"
}

variable "ingress_ipv6_cidr_blocks" {
  type = list(string)
  description = "ingress ipv6 cidr block list"
}

variable "egress_description" {
  type = string
  description = "egress description"
}
variable "egress_from_port" {
  type = number
  description = "egress from port"
}

variable "egress_to_port" {
  type = number
  description = "egress to port"
}

variable "egress_protocol" {
  type = string
  description = "egress protocol"
}

variable "egress_cidr_blocks" {
  type = list(string)
  description = "egress cidr block list"
}

variable "egress_ipv6_cidr_blocks" {
  type = list(string)
  description = "egress ipv6 cidr block list"
}

variable "tags" {
  description = "tags"
	type = map(string)
}


