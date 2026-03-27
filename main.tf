# ---------------- VPC ----------------
module "vpc" {
  source = "./modules/vpc"

  aws_region                = var.aws_region
  vpc_cidr                  = "10.0.0.0/16"
  public_subnet_cidr        = "10.0.1.0/24"
  private_subnet_cidr       = "10.0.2.0/24"
  availability_zone_public  = "ap-south-1a"
  availability_zone_private = "ap-south-1b"
}

# ---------------- Security Group ----------------
module "aws_security_group" {
  source  = "./modules/aws_security_group"
  sg_name = "devops-sg"
  vpc_id  = module.vpc.vpc_id
  #allowed_ssh_cidr = "0.0.0.0/0"
}

# ---------------- EC2 ----------------

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

module "ec2" {
  source               = "./modules/ec2"
  ami                  = data.aws_ami.amazon_linux.id
  instance_name        = var.instance_name
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_id
  iam_instance_profile = module.iam.jenkins_instance_profile_name
  vpc_security_group_ids = [
    module.aws_security_group.sg_id
  ]
}

# ---------------- Key Pair ----------------
resource "aws_key_pair" "jenkins" {
  key_name   = "jenkins-key"
  public_key = file("${path.module}/keys/ssh-ed25519.pub")
}

# ---------------- Jenkins ----------------
module "jenkins" {
  source = "./modules/jenkins"

  instance_id          = module.jenkins.instance_id
  ami                  = "ami-013cb19ee7faa9342"
  instance_type        = "t3.micro"
  public_subnet_id     = module.vpc.public_subnet_id
  security_group_id    = module.aws_security_group.jenkins_sg_id
  key_name             = aws_key_pair.jenkins.key_name
  iam_instance_profile = module.iam.jenkins_instance_profile_name
  jenkins_role_name    = module.iam.jenkins_ec2_role_name

}
#---------------S3---------------
module "s3" {
  source            = "./modules/s3"
  bucket_name       = "mohini-jenkins-artifacts"
  enable_versioning = true
  aws_iam_role      = module.iam.jenkins_ec2_role_name # <-- pass the IAM role here
  acl               = "private"
  tags = {
    Project = "Jenkins-CI"
    Owner   = "DevOpsTeam"
  }
}

#-----------------------IAM ---------------------

module "iam" {
  source         = "./modules/iam"
  s3_buckets_arn = [module.s3.artifacts_bucket_arn]
  bucket_name    = module.s3.artifacts_bucket_name
}


#----------------CloudWatch ----------------------
module "cloudwatch" {
  source = "./modules/cloudwatch"

  instance_ids = [
    module.ec2.instance_id,
    module.jenkins.instance_id
  ]

  alarm_email = "mahikashyap799@gmail.com"
}


