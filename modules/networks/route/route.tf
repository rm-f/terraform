
resource "aws_route" "igw_route" {
  count = length(var.internet_gateway_ids)
  route_table_id = var.route_table_id
  destination_cidr_block = var.cidr_block 
  gateway_id = var.internet_gateway_ids[count.index]
}

resource "aws_route" "nat_route" {
  count = length(var.nat_gateway_ids)
  route_table_id = var.route_table_id
  destination_cidr_block = var.cidr_block
  nat_gateway_id = var.nat_gateway_ids[count.index]
}