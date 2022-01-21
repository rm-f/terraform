resource "aws_iam_role" "ec2_iam_role" {
	name = "${var.asg_name}-ec2-role"
	assume_role_policy = jsonencode({
		Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
	})
	tags = merge(
		{
			Name =  "${var.asg_name}-ec2-role"
		}
	)
}

resource "aws_iam_role_policy_attachment" "name" {
  count = length(var.role_policy_attachments)  
  role = aws_iam_role.ec2_iam_role.name 
  policy_arn = var.role_policy_attachments[count.index]
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.asg_name}-profile"
  role = aws_iam_role.ec2_iam_role.name
}


data "template_file" "ec2_user_data" {
  template = <<EOF
#!/bin/bash
yum update -y
EOF
}

resource "aws_launch_template" "launch_template" {
	name = "${var.asg_name}-template"
	image_id	= var.ami_id
	instance_type = var.instance_type
	# vpc_security_group_ids = var.associate_public_ip ? [] : var.sg_group_ids
	# vpc_security_group_ids = var.sg_group_ids
	key_name = var.key_pair

	iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  # ebs_optimized = true

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
		security_groups = var.sg_group_ids
  }

	tags = merge(
		{
			Name =  "${var.asg_name}-template"
		}
	)
  # user_data = base64encode("${data.template_file.ec2_user_data.rendered}")
  user_data = filebase64("./start.sh")
}

resource "aws_autoscaling_group" "asg" {
	name = "${var.asg_name}"

	vpc_zone_identifier = var.subnet_ids
	desired_capacity = var.desire_size
	min_size = var.min_size
	max_size = var.max_size

	launch_template {
		id = aws_launch_template.launch_template.id
		version = aws_launch_template.launch_template.latest_version
	}

	tags = concat(
		[ 
			{
				key = "Name"
				value = "${var.asg_name}"
				propagate_at_launch = true
			}		
    ],
		var.asg_tags
	)
} 

# resource "aws_autoscaling_group_tag" "asg_tag" {
# 	count = length(asg_tags)	
	
# 	autoscaling_group_name = aws

# 	tag 
# 		key = 
# 	}
# }
