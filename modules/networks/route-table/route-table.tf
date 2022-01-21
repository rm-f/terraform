resource "aws_route_table" "internet_gateway" {
  count = length(var.internet_gateway_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    gateway_id = var.internet_gateway_ids[count.index]
  }

  tags = merge(
		var.route_table_tags,
		{
      Name = var.igw_route_table_name
		}
  )
}

output "igw_route_table_id" {
  value = aws_route_table.internet_gateway
}

resource "aws_route_table_association" "association_igw" {
  count = length(var.internet_gateway_ids)
  subnet_id      = var.igw_subnet_id
  route_table_id = aws_route_table.internet_gateway[count.index].id
}

resource "aws_route_table" "nat_gateway" {
  count = length(var.nat_gateway_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    gateway_id = var.nat_gateway_ids[count.index]
  }

  tags = merge(
		var.route_table_tags,
		{
      Name = var.nat_route_table_name
		}
  )
}

output "natgw_route_table_id" {
  value = aws_route_table.nat_gateway
}

resource "aws_route_table_association" "association_natgw" {
  count = length(var.nat_gateway_ids)
  subnet_id      = var.natgw_subnet_id
  route_table_id = aws_route_table.nat_gateway[count.index].id
}



