# this is for VPC creation 
resource "aws_vpc" "this" {
    cidr_block =var.vpc_cidr

    tags = {
        Name = "terraform-vpc"
    }
}

# this is for Public subnet call:

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.this.id
    cidr_block = var.subnet_cidr
    availability_zone =  var.availability_zone

    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet"
    }
}

# this is for private subnet 

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.this.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.availability_zone

    tags = {
        Name = "private-subnet"
    }
}

# this is for internet gateway call to connect with internet 

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "terraform-IGW"
    }
}

# here we are opening routetable for all internet

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.this.id
   
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
   }

   tags = {
    Name = "public-route-table"
   }
}

# this is for route table assosiation: subnet connect internet
resource "aws_route_table_association" "assoc"{
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public_rt.id
}