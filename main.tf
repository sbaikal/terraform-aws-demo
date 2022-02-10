#data "aws_ssm_parameter" "ami" {
#  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
#}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}
##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "demo_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id

}

resource "aws_subnet" "subnet1" {
  cidr_block              = var.cidr_block
  vpc_id                  = aws_vpc.demo_vpc.id
  map_public_ip_on_launch = "true"
}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta-subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rtb.id
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = aws_vpc.demo_vpc.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# INSTANCES #
resource "aws_instance" "nginx1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<EOF
#! /bin/bash
sudo apt install -y nginx
sudo systemctl start nginx
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Home Assignment </title></head><body>Demo from Baikal!</body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF

}

output "public_ip" {
  value = aws_instance.nginx1.public_ip
  
}

