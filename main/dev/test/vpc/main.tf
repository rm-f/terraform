provider "aws" {
	region = "ap-northeast-2"
}

module "vpc" {
  source = "../../../../modules/networks/vpc"
  vpc_name = "dev-01-vpc"
  vpc_cidr_block = "10.0.0.0/16"
  vpc_instance_tenancy = "default"
  vpc_tags = {}
}

module "subnet-pub-01" {
  source = "../../../../modules/networks/subnet"
  vpc_name = module.vpc.id
  subnet_name = "dev-01-svc-2a-pub-sn"
  subnet_cidr_block = "10.0.3.0/24"
  subnet_availability_zone = "ap-northeast-2a"
  subnet_map_public_ip_on_launch = true
  subnet_tags = {}
}

module "subnet-pub-02" {
  source = "../../../../modules/networks/subnet"
  vpc_name = "dev-01-vpc"
  subnet_name = "dev-01-svc-2c-pub-sn"
  subnet_cidr_block = "10.0.5.0/24"
  subnet_availability_zone = "ap-northeast-2c"
  subnet_map_public_ip_on_launch = true
  subnet_tags = {}
}

module "subnet-pri-01" {
  source = "../../../../modules/networks/subnet"
  vpc_name = "dev-01-vpc"
  subnet_name = "dev-01-svc-2a-pri-sn"
  subnet_cidr_block = "10.0.4.0/24"
  subnet_availability_zone = "ap-northeast-a2"
  subnet_map_public_ip_on_launch = false
  subnet_tags = {}
}

module "subnet-pri-02" {
  source = "../../../../modules/networks/subnet"
  vpc_name = "dev-01-vpc"
  subnet_name = "dev-01-svc-2c-pri-sn"
  subnet_cidr_block = "10.0.6.0/24"
  subnet_availability_zone = "ap-northeast-2c"
  subnet_map_public_ip_on_launch = false
  subnet_tags = {}
}

module "internet-gateway-01" {
  source = "../../../../modules/networks/internet-gateway"
  vpc_name = "dev-01-vpc"
  gateway_name = "dev-01-svc-igw"
  gateway_tags = {}
}

module "internet-gateway-02" {
  source = "../../../../modules/networks/internet-gateway"
  vpc_name = "dev-01-vpc"
  gateway_name = "dev-02-svc-igw"
  gateway_tags = {}
}

module "nat-gateway-01" {
  source = "../../../../modules/networks/nat-gateway-pub"
  subnet_name = "dev-01-svc-pub-sn"
  internet_gateway_name = "dev-01-svc-igw"
  nat_gateway_name = "dev-01-svc-natgw"
  connectivity_type = "public"
  gateway_tags = {}
}

module "route-table" {
  source = "../../../../modules/networks/route-table"
  igw_route_table_name = "dev-01-svc-2a-route"
  nat_route_table_name = ""
  vpc_name = "dev-01-vpc"
  igw_subnet_name = "dev-01-svc-2a-pub-sn"
  natgw_subnet_name = ""
  internet_gateway_names = ["dev-02-svc-igw"]
  nat_gateway_names = []
  cidr_block = "0.0.0.0/0"
  route_table_tags = {}
}

module "route" {
  source = "../../../../modules/networks/route"
  route_table = "dev-01-svc-2a-route"
  internet_gateway_names = ["dev-02-svc-igw"]
  nat_gateway_names = []
  cidr_block = "10.0.2.0/24"
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


