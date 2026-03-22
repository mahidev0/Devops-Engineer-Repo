variable "instance_type" {}
variable "public_subnet_id" {}
variable "security_group_id" {}
variable "key_name" {}
variable "ami" {}
variable "iam_instance_profile" {
  description = "IAM instance profile to attach to Jenkins EC2"
  type        = string
}