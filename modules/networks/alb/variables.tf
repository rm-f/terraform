variable "tags" {
	description = "service tags"
	type = map(string)
	default = {
        Type = "dev",
	}
}

variable "vpc_name" {
  description = "vpc name" 
  type = string
}

variable "subnet_names" {
  description = "internet gateway subnet name" 
  type = list(string)
}

variable "alb" {
	description = "alb config"
	type = object({
		name = string
		is_internal = bool
    type = string
	})
}

variable "target_groups" {
	description = "alb config"
	type = list(object({
		name = string
		port = number
		type = string
		health_check_path = string
		health_check_port = number
	}))
}

variable "listner" {
	description = "alb listner config"
	type = object({
		name = string
    port = string
    protocol = string
    ssl_policy = string
    certificate_arn = string
    target_group_index = number 
    type = string
	})
}
