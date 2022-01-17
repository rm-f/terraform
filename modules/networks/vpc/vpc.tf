resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = var.vpc_instance_tenancy

  tags = merge(
		var.vpc_tags,
		{
			Name =  var.vpc_name
		}
	)
}

output "output_vpc_name" {
    value = aws_vpc.vpc.tags.Name
}

