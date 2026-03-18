# this is for vpc calling variable and all variable mention in variable.tf file.

module "vpc" {
  source = "./modules/vpc"

  aws_region = var.aws_region
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone_public  = "ap-south-1a"
  availability_zone_private = "ap-south-1b"
}

# this is caaling ec2

module "ec2" {
  source = "./modules/ec2"

  instance_name = var.instance_name
  instance_type = var.instance_type

  subnet_id = module.vpc.public_subnet_id
}