output "sg_id" {
  description = "Security Group ID"
  value       = aws_security_group.this.id
}

output "sg_name" {
  description = "Security Group Name"
  value       = aws_security_group.this.name
}

output "jenkins_sg_id" {
  value = aws_security_group.jenkins_sg.id
}