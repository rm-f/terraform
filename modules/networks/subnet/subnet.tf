# data "aws_vpc" "current" {
#   tags = {
#     Name = var.vpc_name
#   }
# }

resource "aws_subnet" "create" {
  # vpc_id     = data.aws_vpc.current.id
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.subnet_availability_zone
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch

  tags = merge(
		var.subnet_tags,
		{
      Name = var.subnet_name
		}
	)
}

output "subnet_id" {
    value = aws_subnet.create.id
}