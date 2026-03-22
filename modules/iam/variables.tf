variable "jenkins_ec2_role_name" {
  description = "Name of IAM Role for Jenkins EC2"
  type        = string
  default     = "jenkins-ec2-role"
}

variable "jenkins_s3_policy_name" {
  description = "Name of IAM Policy for Jenkins S3 access"
  type        = string
  default     = "jenkins-s3-policy"
}

variable "jenkins_instance_profile_name" {
  description = "Name of IAM Instance Profile for Jenkins EC2"
  type        = string
  default     = "jenkins-instance-profile"
}

variable "s3_buckets_arn" {
  description = "List of S3 bucket ARNs Jenkins EC2 can access"
  type        = list(string)
  default     = []
}