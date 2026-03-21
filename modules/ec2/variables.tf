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
