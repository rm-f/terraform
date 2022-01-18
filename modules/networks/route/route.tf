data "aws_route_table" "selected" {
  tags = {
    Name = var.route_table
  }
}

data "aws_internet_gateway" "igws"{
  count = length(var.internet_gateway_names)
  tags = {
    Name = var.internet_gateway_names[count.index]
  } 
}

resource "aws_route" "igw_route" {
  count = length(var.internet_gateway_names)
  route_table_id            = data.aws_route_table.selected.id
  destination_cidr_block    = var.cidr_block 
  gateway_id = data.aws_internet_gateway.igws[count.index].id
}

data "aws_nat_gateway" "natgws"{
  count = length(var.nat_gateway_names)
  tags = {
    Name = var.nat_gateway_names[count.index]
  } 
}

resource "aws_route" "nat_route" {
  count = length(var.nat_gateway_names)
  route_table_id            = data.aws_route_table.selected.id
  destination_cidr_block    = var.cidr_block
  nat_gateway_id = data.aws_nat_gateway.natgws[count.index].id
}