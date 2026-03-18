variable "vpc_cidr" {}
variable  "public_subnet_cidr"{}
variable "private_subnet_cidr" {}
#variable "subnet_cidr" {}
#variable "availability_zone" {}

variable  "availability_zone_public" {
      description = "Public subnet AZ"
    type = string
}

variable "availability_zone_private"{
        description = "Private subnet AZ"
    type = string 
}

variable "aws_region" {
    type = string  
}