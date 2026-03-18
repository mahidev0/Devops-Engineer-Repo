# this is for vpc calling variable and all variable mention in variable.tf file.

module "vpc" {
    source           = "./modules/vpc"
    vpc_cidr         = var.vpc_cidr
    subnet_cidr      = var.subnet_cidr
    availability_zone = var.availability_zone
}



# this is caaling ec2

module "ec2" {
    source ="./modules/ec2"

    instance_name =var.instance_name
    instance_type = var.instance_type

    subnet_id = module.vpc.subnet_id
}