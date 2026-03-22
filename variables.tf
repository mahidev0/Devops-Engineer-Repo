variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_name" {}
variable "instance_type" {}

variable "vpc_cidr" {}
variable "subnet_cidr" {}
variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH"
  type        = string
  default     = "0.0.0.0/0"
}


#variable "availability_zone" {}
