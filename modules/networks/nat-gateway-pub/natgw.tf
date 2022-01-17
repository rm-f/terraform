data "aws_subnet" "selected" {
  tags = {
    Name = var.subnet_name
  }
}

data "aws_internet_gateway" "selected" {
  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = data.aws_subnet.selected.id
  connectivity_type = var.connectivity_type
  tags =  merge(
		var.gateway_tags,
		{
      Name = var.nat_gateway_name
		}
  )
}