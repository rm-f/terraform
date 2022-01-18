data "aws_vpc" "current" {
  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnet_ids" "currents" {
  count = length(subnet_names)
  tags = {
    Name = var.subnet_name[count.index]
  }
}

resource "aws_lb" "alb" {
  name = "${lookup(var.alb, "name")}"
  for_each = data.aws_subnet_ids.current.ids  

  internal = "${lookup(var.alb, "is_internal")}"
  load_balancer_type = "${lookup(var.alb[count.index], "type")}"
  subnets = each.value

  enable_deletion_protection = true

  tags = merge(
		{
      Name = "${lookup(var.alb, "name")}"
		}
  )
}

resource "aws_lb_target_group" "lb_target_group" {
  count = length(var.target_groups)
  name = "${lookup(var.target_groups[count.index], "name")}" 
  port = lookup(var.target_groups[count.index], "port")
  target_type = lookup(var.target_groups[count.index], "type")
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check {
    enabled = true
    path = lookup(var.target_groups[count.index], "health_check_path")
    port = lookup(var.target_groups[count.index], "health_check_port")
  }
}

resource "aws_security_group" "elb_security_group" {
	name = "${lookup(var.alb[count.index], "name")}-sg"
	vpc_id = data.aws_vpc.current.id

	tags = merge(
		var.tags,
		{
			Name = "${lookup(var.alb[count.index], "name")}-sg"
		}
	)
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb[count.index].arn
  port = lookup(var.listner, "port") 
  protocol = lookup(var.listner, "protocol")
  ssl_policy = lookup(var.listner, "ssl_policy")
  certificate_arn = lookup(var.listner, "certificate_arn")

  default_action {
    type = lookup(var.listner, "type")
    target_group_arn = aws_lb_target_group.lb_target_group[lookup(var.listner, "target_group_index")].arn
  }
}
