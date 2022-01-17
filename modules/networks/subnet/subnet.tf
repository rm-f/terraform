data "aws_vpc" "current" {
  tags = {
    Name = var.vpc_name
  }
}

output "output_vpc_id" {
    value = data.aws_vpc.current.id
}


resource "aws_subnet" "subnet" {
  vpc_id     = data.aws_vpc.current.id
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