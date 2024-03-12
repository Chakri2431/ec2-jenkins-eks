provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "J-vpc" {
  cidr_block = var.aws_vpc_cidr
  tags = {
    name = "J-vpc"
  }
  
}

  resource "aws_subnet" "J-subnet" {
    vpc_id           = aws_vpc.J-vpc.id
    cidr_block       = var.subnet_cidr
    map_public_ip_on_launch = true
    tags = {
      name = "J-subnet"  }
  }
resource "aws_internet_gateway" "J-igw" {
  vpc_id = aws_vpc.J-vpc.id
  tags = {
    name = "J-igw"
  }
  
}
resource "aws_route_table" "J-rt" {
  vpc_id = aws_vpc.J-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.J-igw.id

}
  tags = {
    name = "J-rt"
  }
} 
resource "aws_route_table_association" "J-rta" {
  subnet_id      = aws_subnet.J-subnet.id
  route_table_id = aws_route_table.J-rt.id
}
resource "aws_instance" "J-ec2" {
  ami           = var.ami_id
  instance_type = var.aws_instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.J-subnet.id
  security_groups = [aws_security_group.J-sg.id]
  user_data = "./modules/vpc/jenkins-install.sh"
  tags = {
    name = "J-ec2"
  }
  
}
resource "aws_security_group" "J-sg" {
        vpc_id = aws_vpc.J-vpc.id
        ingress {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
    
          from_port   = 8080
          to_port     = 8080
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
        egress {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
  
}
      }

  
output "aws_instance_public_ip" {
  value = aws_instance.J-ec2.public_ip
  
}
output "aws_instance_private_ip" {
  value = aws_instance.J-ec2.private_ip
}










      
