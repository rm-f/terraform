data "aws_vpc" "current" {
  tags = {
    Name = var.vpc_name
  }
}

output "output_vpc_id" {
    value = data.aws_vpc.current.id
}

data "aws_subnet" "igw_subnet" {
  tags = {
    Name = var.igw_subnet_name
  }
}

data "aws_subnet" "natgw_subnet" {
  tags = {
    Name = var.natgw_subnet_name
  }
}


data "aws_internet_gateway" "igws"{
  count = length(var.internet_gateway_names)
  tags = {
    Name = var.internet_gateway_names[count.index]
  } 
}

resource "aws_route_table" "internet_gateway" {
  count = length(var.internet_gateway_names)
  vpc_id = data.aws_vpc.current.id

  route {
    cidr_block = var.cidr_block
    gateway_id = data.aws_internet_gateway.igws[count.index].id
  }

  tags = merge(
		var.route_table_tags,
		{
      Name = var.route_table_name
		}
  )
}

data "aws_nat_gateway" "natgws"{
  count = length(var.nat_gateway_names)
  tags = {
    Name = var.nat_gateway_names[count.index]
  } 
}

resource "aws_route_table" "nat_gateway" {
  count = length(var.nat_gateway_names)
  vpc_id = data.aws_vpc.current.id

  route {
    cidr_block = var.cidr_block
    gateway_id = data.aws_nat_gateway.natgws[count.index].id
  }

  tags = merge(
		var.route_table_tags,
		{
      Name = var.route_table_name
		}
  )
}

resource "aws_route_table_association" "association_igw" {
  count = length(var.internet_gateway_names)
  subnet_id      = data.aws_subnet.igw_subnet.id
  route_table_id = aws_route_table.internet_gateway[count.index].id
}

resource "aws_route_table_association" "association_natgw" {
  count = length(var.nat_gateway_names)
  subnet_id      = data.aws_subnet.natgw_subnet.id
  route_table_id = aws_route_table.nat_gateway[count.index].id
}



