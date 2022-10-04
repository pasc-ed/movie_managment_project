# VPC of Talent-Academy Lab account
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Public Subnet
data "aws_subnet" "public_subnet_a" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_a_name]
  }
}

# AMI FOR UBUNTU image
data "aws_ami" "amz_linux_image" {
  most_recent = true
  owners      = [var.amzn_ami_owner]

  filter {
    name   = "name"
    values = [var.amzn_ami_name]
  }
}