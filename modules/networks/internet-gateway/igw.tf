resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id 

  tags =  merge(
		var.gateway_tags,
		{
      Name = var.gateway_name
		}
  )
}
output "igw_id" {
  value = aws_internet_gateway.gw.id
}
