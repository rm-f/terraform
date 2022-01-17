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

module "subnet-pub" {
  source = "../../../../modules/networks/subnet"
  vpc_name = "dev-01-vpc"
  subnet_name = "dev-01-svc-pub-sn"
  subnet_cidr_block = "10.0.1.0/24"
  subnet_availability_zone = ""
  subnet_map_public_ip_on_launch = true
  subnet_tags = {}
}

module "subnet-pri" {
  source = "../../../../modules/networks/subnet"
  vpc_name = "dev-01-vpc"
  subnet_name = "dev-01-svc-pri-sn"
  subnet_cidr_block = "10.0.2.0/24"
  subnet_availability_zone = ""
  subnet_map_public_ip_on_launch = false
  subnet_tags = {}
}

module "internet-gateway" {
  source = "../../../../modules/networks/internet-gateway"
  vpc_name = "dev-01-vpc"
  gateway_name = "dev-01-svc-igw"
  gateway_tags = {}
}

module "nat-gateway" {
  source = "../../../../modules/networks/nat-gateway-pub"
  subnet_name = "dev-01-svc-pub-sn"
  internet_gateway_name = "dev-01-svc-igw"
  nat_gateway_name = "dev-01-svc-natgw"
  connectivity_type = "public"
  gateway_tags = {}
}

module "route-table" {
  source = "../../../../modules/networks/route-table"
  route_table_name = "dev-01-vpc-route"
  vpc_name = "dev-01-vpc"
  igw_subnet_name = "dev-01-svc-pub-sn"
  natgw_subnet_name = "dev-01-svc-pri-sn"
  internet_gateway_names = ["dev-01-svc-igw"]
  nat_gateway_names = ["dev-01-svc-natgw"]
  cidr_block = "0.0.0.0/0"
  route_table_tags = {}
}


