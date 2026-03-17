#this is for ami id calling , using data blaock

data "aws_ami" "amazon_linux"{
    most_recent = true
    owners     = ["amazon"]

#Select amazon linux 2 x86 image
 filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
     }

# Ensure architecture matches instance type 
filter{
    name = "architecture"
    values = ["x86_64"]
}     

filter {
    name = "virtualization-type"
    values = ["hvm"]
}
}

## this is for ec2 instance calling 

resource "aws_instance" "this"{
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type

    tags = {
        Name = var.instance_name 
        Environment = "lab"
        Managedby = "Terraform"
    }
}