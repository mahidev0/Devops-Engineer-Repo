resource "aws_iam_role" "jenkins_ec2_role" {
  name = "jenkins_ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "random_id" "policy_suffix" {
  byte_length = 4
}
resource "aws_iam_policy" "jenkins_s3_policy" {
  name   = "jenkins-s3-policy-${random_id.policy_suffix.hex}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:GetObject","s3:PutObject","s3:ListBucket"]
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_s3_attach" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = aws_iam_policy.jenkins_s3_policy.arn
}

resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name = var.jenkins_instance_profile_name
  role = aws_iam_role.jenkins_ec2_role.name
}

#Adding cloudwatch 



# CloudWatch Agent Permission
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_attach" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}