provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "Terra_Vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "Terra_VPC"
  }
}

module "VPC_Subnets" {
  source = "./modules/VPC_Subnets"
  vpcid = aws_vpc.Terra_Vpc.id
  sn_cidr_block = var.sn_cidr_block
  sn_cidr_block1 = var.sn_cidr_block1
  availability_zn = var.availability_zn
}

module "Ec2" {
  source = "./modules/Ec2"
  vpcid_Ec2 = aws_vpc.Terra_Vpc.id
  SN_ID = module.VPC_Subnets.subnet.id
  availability_zn = var.availability_zn
}




