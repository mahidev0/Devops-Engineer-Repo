## this is for ec2 instance calling 

resource "aws_instance" "this"{
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    subnet_id = var.subnet_id   # this add for vpc ec2 instance, Now its depend on vpc

    tags = {
        Name = var.instance_name 
        Environment = "lab"
        Managedby = "Terraform"
    }
}

