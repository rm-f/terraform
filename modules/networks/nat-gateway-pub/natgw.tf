resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.subnet_id
  connectivity_type = var.connectivity_type
  tags =  merge(
		var.gateway_tags,
		{
      Name = var.nat_gateway_name
		}
  )
}

output "natgw_id" {
  value = aws_nat_gateway.nat_gateway.id
}