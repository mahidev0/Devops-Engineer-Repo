data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins_profile"
  role = var.jenkins_role_name
}

resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.jenkins_profile.name
  user_data              = file("${path.module}/user_data.sh")
  tags = {
    Name = "jenkins-server"
  }
}

resource "aws_eip" "jenkins_eip" {
  domain = "vpc"
 # lifecycle {
  #  prevent_destroy = true
  #}
  tags = {
    Name = "jenkins-eip"
  }
}

resource "aws_eip_association" "jenkins_eip_assoc" {
  instance_id   = aws_instance.jenkins.id
 allocation_id = aws_eip.jenkins_eip.id
}


