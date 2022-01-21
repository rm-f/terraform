provider "aws" {
	region = "ap-northeast-2"
}

module "vpc" {
  source = "../../../../modules/networks/vpc"
  vpc_name = "dev-01-vpc"
  vpc_cidr_block = "10.0.0.0/16"
  vpc_instance_tenancy = "default"
  enable_dns_hostnames = true
  vpc_tags = {}
}

module "subnet_pub_01" {
  source = "../../../../modules/networks/subnet"
  vpc_id = module.vpc.vpc_id
  subnet_name = "dev-01-svc-2a-pub-sn"
  subnet_cidr_block = "10.0.3.0/24"
  subnet_availability_zone = "ap-northeast-2a"
  subnet_map_public_ip_on_launch = true
  subnet_tags = {}
}

module "subnet_pub_02" {
  source = "../../../../modules/networks/subnet"
  vpc_id = module.vpc.vpc_id
  subnet_name = "dev-01-svc-2c-pub-sn"
  subnet_cidr_block = "10.0.5.0/24"
  subnet_availability_zone = "ap-northeast-2c"
  subnet_map_public_ip_on_launch = true
  subnet_tags = {}
}

# module "subnet_pri_01" {
#   source = "../../../../modules/networks/subnet"
#   vpc_id = module.vpc.vpc_id
#   subnet_name = "dev-01-svc-2a-pri-sn"
#   subnet_cidr_block = "10.0.4.0/24"
#   subnet_availability_zone = "ap-northeast-2a"
#   subnet_map_public_ip_on_launch = false
#   subnet_tags = {}
# }

# module "subnet_pri_02" {
#   source = "../../../../modules/networks/subnet"
#   vpc_id = module.vpc.vpc_id
#   subnet_name = "dev-01-svc-2c-pri-sn"
#   subnet_cidr_block = "10.0.6.0/24"
#   subnet_availability_zone = "ap-northeast-2c"
#   subnet_map_public_ip_on_launch = false
#   subnet_tags = {}
# }

module "internet_gateway_01" {
  source = "../../../../modules/networks/internet-gateway"
  vpc_id = module.vpc.vpc_id
  gateway_name = "dev-01-svc-igw"
  gateway_tags = {}
}

# module "internet-gateway-02" {
#   source = "../../../../modules/networks/internet-gateway"
#   vpc_name = "dev-01-vpc"
#   gateway_name = "dev-02-svc-igw"
#   gateway_tags = {}
# }

# module "nat_gateway_01" {
#   source = "../../../../modules/networks/nat-gateway-pub"
#   subnet_id = module.subnet_pub_01.subnet_id
#   nat_gateway_name = "dev-01-svc-natgw"
#   connectivity_type = "public"
#   gateway_tags = {}
# }

module "route_table_01" {
  source = "../../../../modules/networks/route-table"
  vpc_id = module.vpc.vpc_id
  igw_route_table_name = "dev-01-svc-2a-route"
  internet_gateway_ids = [module.internet_gateway_01.igw_id]
  igw_subnet_id = module.subnet_pub_01.subnet_id

  nat_route_table_name = ""
  nat_gateway_ids = []
  natgw_subnet_id = ""

  cidr_block = "0.0.0.0/0"
  route_table_tags = {}
}

module "route_table_associate" {
  source = "../../../../modules/networks/route-associate-subnet"
  subnet_ids = [module.subnet_pub_02.subnet_id]
  route_table_id = module.route_table_01.igw_route_table_id[0].id
}

# module "route_table_02" {
#   source = "../../../../modules/networks/route-table"
#   vpc_id = module.vpc.vpc_id
#   igw_route_table_name = "dev-01-svc-2c-route"
#   internet_gateway_ids = [module.internet_gateway_01.igw_id]
#   igw_subnet_id = module.subnet_pub_01.subnet_id

#   nat_route_table_name = ""
#   nat_gateway_ids = []
#   natgw_subnet_id = ""

#   cidr_block = "0.0.0.0/0"
#   route_table_tags = {}
# }

# module "route" {
#   source = "../../../../modules/networks/route"
#   route_table_id = module.route_table.igw_route_table_id[0].id
#   internet_gateway_ids = [module.internet_gateway_01.igw_id]
#   nat_gateway_ids = []
#   cidr_block = "10.0.2.0/24"
# }

module "asg_sg" {
  source = "../../../../modules/networks/security-group"
  name = "luke-default-sg"
  description = "default security group"
  vpc_id = module.vpc.vpc_id
  # vpc_id = "vpc-01bbd70b330e1dcc9"
  ingress_description = "any open"
  ingress_from_port = 0
  ingress_to_port = 65535
  ingress_protocol = "TCP"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_ipv6_cidr_blocks = ["::/0"]
  egress_description = "any"
  egress_from_port = 0
  egress_to_port = 0
  egress_protocol = "-1"
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks = ["::/0"]

  tags = {
      env = "test"
      managed = "terraform"
  }

}

module "asg" {
  source = "../../../../modules/ec2/autoscaling-group"
  asg_name = "luke-svc"
  role_policy_attachments = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
    ]
  ami_id = "ami-0b1d3b1941f23c7d5"
  # ami_id = "ami-0781ede7661c6cd6e"
  instance_type = "t2.micro"
  sg_group_ids = [module.asg_sg.sg_id]
  key_pair = "luke_default"
  associate_public_ip = true
  subnet_ids = [module.subnet_pub_01.subnet_id, module.subnet_pub_02.subnet_id]
  # subnet_ids = ["subnet-0072d848c5f437374"]
  desire_size = 1
  min_size = 1
  max_size = 2
  tags = {}
  asg_tags = [
    {
      key = "test"
      value = "test"
      propagate_at_launch = true 
    },
    {
      key = "test01"
      value = "test01"
      propagate_at_launch = false
    }
  ]
}


# module "alb" {
#   source = "../../../../modules/networks/alb"
#   vpc_name = "dev-01-vpc"
#   subnet_names = ["dev-01-svc-pub-sn"]
#   natgw_subnet_name = "dev-01-svc-pri-sn"
#   internet_gateway_names = ["dev-01-svc-igw"]
#   nat_gateway_names = ["dev-01-svc-natgw"]
#   cidr_block = "0.0.0.0/0"
#   route_table_tags = {}
# }


