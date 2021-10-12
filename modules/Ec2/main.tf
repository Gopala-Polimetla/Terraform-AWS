data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "VPC_SG" {
  name = "VPC_SG"
  vpc_id = var.vpcid_Ec2

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    Name = "Terra_SG"
  }
}

resource "aws_instance" "Vpc_Instance" {
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = "t2.micro"
  subnet_id = var.SN_ID
  vpc_security_group_ids = [aws_security_group.VPC_SG.id]
  availability_zone = var.availability_zn
  associate_public_ip_address = true
  key_name = "Devops-Demo"
  tags = {
    Name = "Vpc-Demo-EC2-Instance"
  }
}
