data "aws_vpc" "current" {
  tags = {
    Name = var.vpc_name
  }
}

output "output_vpc_id" {
    value = data.aws_vpc.current.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id     = data.aws_vpc.current.id

  tags =  merge(
		var.gateway_tags,
		{
      Name = var.gateway_name
		}
  )
}
