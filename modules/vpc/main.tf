resource "aws_vpc" "this" {
    cidr_block =var.vpc_cidr

    tags = {
        Name = "terraform-vpc"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.this.id
    cidr_block = var.subnet_cidr
    availability_zone =  var.availability_zone

    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.this.id
}

resource "aws_route" "internet_access"{
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "assoc"{
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public_rt.id
}