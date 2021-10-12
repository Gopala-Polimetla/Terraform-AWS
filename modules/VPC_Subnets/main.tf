resource "aws_subnet" "Vpc_SN" {
  vpc_id = var.vpcid
  cidr_block = var.sn_cidr_block
  availability_zone = var.availability_zn

  tags = {
    Name = "Terra_SN"
  }
}

resource "aws_internet_gateway" "Vpc_IGW" {
  vpc_id = var.vpcid
  tags = {
    Name = "Terra_IGW"
  }
}

resource "aws_route_table" "Vpc_RT" {
  vpc_id = var.vpcid

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Vpc_IGW.id
  }
  tags = {
    Name = "Terra_RT"
  }
}

resource "aws_route_table_association" "Vpc_RT_Associaton" {
  subnet_id = aws_subnet.Vpc_SN.id
  route_table_id = aws_route_table.Vpc_RT.id
}