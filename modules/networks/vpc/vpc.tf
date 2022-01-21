resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = var.vpc_instance_tenancy
	enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
		var.vpc_tags,
		{
			Name =  var.vpc_name
		}
	)
}

output "vpc_id" {
    value = aws_vpc.vpc.id
}

