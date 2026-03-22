output "jenkins_ec2_role_arn" {
  value = aws_iam_role.jenkins_ec2_role.arn
}

output "jenkins_instance_profile_name" {
  value = aws_iam_instance_profile.jenkins_instance_profile.name
}

output "jenkins_s3_policy_arn" {
  value = aws_iam_policy.jenkins_s3_policy.arn
}