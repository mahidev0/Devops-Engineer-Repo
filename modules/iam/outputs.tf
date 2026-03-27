
output "jenkins_ec2_role_arn" {
  value = aws_iam_role.jenkins_ec2_role.arn
}

output "jenkins_instance_profile_name" {
  value = aws_iam_instance_profile.jenkins_instance_profile.name
}

output "jenkins_s3_policy_arn" {
  value = aws_iam_policy.jenkins_s3_policy.arn
}

# modules/iam/outputs.tf
output "jenkins_ec2_role_name" {
  value       = aws_iam_role.jenkins_ec2_role.name  # replace with your IAM role resource name
  description = "The IAM role name attached to Jenkins EC2"
}

