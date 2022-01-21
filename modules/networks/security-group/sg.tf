resource "aws_security_group" "created" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress {
    description      = var.ingress_description
    from_port        = var.ingress_from_port 
    to_port          = var.ingress_to_port
    protocol         = var.ingress_protocol
    cidr_blocks      = var.ingress_cidr_blocks
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
  }

  egress {
    description      = var.egress_description
    from_port        = var.egress_from_port
    to_port          = var.egress_to_port
    protocol         = var.egress_protocol
    cidr_blocks      = var.egress_cidr_blocks
    ipv6_cidr_blocks = var.egress_ipv6_cidr_blocks
  }

	tags = merge(
    var.tags,
		{
			Name =  "${var.name}"
		}
	)
}

output "sg_id" {
  value = aws_security_group.created.id
}