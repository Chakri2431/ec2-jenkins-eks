provider "aws"  {
  region = "us-east-1"
  
}

module "vpc" {
  source = "./modules/vpc"
  aws_vpc_cidr = var.aws_vpc_cidr
  tags = {
    name = "J-vpc"
  }
  subnet_cidr = var.subnet_cidr
  subnet_tags = {
    name = "J-subnet"
  }
  security_group_name = var.security_group_name
    security_group_tags = {
        name = "J-sg"
  
   ami_id = "ami-0f403e3180720dd7e"
    aws_instance_type = "t2.micro"
    key_name = "jenkins-key"
    user_data = "./modules/vpc/jenkins-install.sh"
    instance_tags = {
      name = "J-ec2"
    }

}
}

 




