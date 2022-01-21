variable "route_table_id" {
  description = "route table id"
  type = string
}

variable "subnet_ids" {
  description = "subnet id list"
  type = list(string)
}