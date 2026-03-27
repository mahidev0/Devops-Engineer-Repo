output "jenkins_public_ip" {
  value = aws_eip.jenkins_eip.public_ip
}

output "jenkins_role_name" {
  value = var.jenkins_role_name
}
output "instance_id" {
  value = aws_instance.jenkins.id
}
