variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable  "public_subnet_cidr"{
    default = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
    default = "10.0.2.0/24"
}
variable "subnet_cidr" {}
variable "availability_zone" {}

variable "aws_region" {
    default = "ap-south-1"
}