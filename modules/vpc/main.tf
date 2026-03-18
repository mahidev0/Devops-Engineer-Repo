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
    cidr_block = var.public_subnet_cidr
    availability_zone = var.availability_zone_public

    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet"
    }
}

# this is for private subnet 

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.this.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.availability_zone_private

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

# this is fr nat eip

resource "aws_eip" "nat_eip"{
    domain = "vpc"

    tags = {
        Name = "NAT-eip"
    }
}

# this is for NAT gateway to connet private subnet with internet 

resource "aws_nat_gateway" "nat"{
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public.id

    tags ={
        Name = "Terraform-NAT"
    }
depends_on = [ aws_internet_gateway.igw ]
}

#this route table for private subnet who are connecting with internet

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
        }

    tags = {
        Name = "private-route-table"
    }
}
# here we are opening routetable for public route table all internet

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

# this is for route table assosiation:  for public subnet connect internet
resource "aws_route_table_association" "assoc"{
   subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# this association is for private subnet route table

resource "aws_route_table_association" "private_assoc"{
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private_rt.id
}