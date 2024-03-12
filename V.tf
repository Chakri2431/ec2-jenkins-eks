variable "aws_instance_type" {
  description = "The type of EC2 instance to launch"
    type = string
    default = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
    type = string
    default = "ami-0f403e3180720dd7e"
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance"
    type = string
    default = "jenkins-key"
}


variable "aws_vpc_cidr" {
  description = "The CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"

}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
    default = "10.0.1.0/24"
    type = string

}


