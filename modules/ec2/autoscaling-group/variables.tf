variable "asg_name" {
  description = "autoscaling group name"
  type = string
}

variable "role_policy_attachments" {
  description = "role policy attachment"
  type = list(string)
}

variable "ami_id" {
  description = "amazon os image id"
  type = string
}

variable "instance_type" {
  description = "instance type"
  type = string
}

variable "sg_group_ids" {
  description = "security group id list"
  type = list(string)
}

variable "key_pair" {
   description = "(optional) describe your variable"
   type = string
} 

variable "associate_public_ip" {
  description = "associate public ip"
  type = bool 
}

variable "subnet_ids" {
  description = "subnet id list"
  type = list(string)
}

variable "desire_size" {
  description = "desire size"
  type = number 
}

variable "max_size" {
  description = "max size"
  type = number 
}

variable "min_size" {
  description = "min size"
  type = number 
}


variable "tags" {
	description = "tags"
	type = map(string)
}

variable "asg_tags" {
  description = "service tags"
  type = list(object({
    key = string
    value = string
    propagate_at_launch = bool
  }))
}
