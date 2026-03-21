
resource "aws_instance" "jenkins" {

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name  
  subnet_id              = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_group_id]
  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "jenkins-server"
  }
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

