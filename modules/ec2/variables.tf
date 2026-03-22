variable "ami" {
  type = string  
}
variable "instance_name"{
    type = string
}
variable "instance_type" {
    type = string
}
variable "subnet_id" {}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "iam_instance_profile" {
  description = "IAM instance profile to attach to EC2"
  type        = string
}