terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.36"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }

  required_version = ">= 1.5.0"
}

# modules/s3/main.tf
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "artifacts_bucket" {
  bucket = "${var.bucket_name}-${random_id.bucket_suffix.hex}"
 
  #force_destroy = true

  tags = merge(
    { Name = var.bucket_name, Environment = "DevOpsProject" },
    var.tags
  )
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifacts_bucket_sse" {
  bucket = aws_s3_bucket.artifacts_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_versioning" "artifacts_bucket_versioning" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.artifacts_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
# modules/s3/main.tf
resource "aws_iam_policy" "jenkins_s3_policy" {
  name   = "jenkins-s3-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::${aws_s3_bucket.artifacts_bucket.bucket}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_s3_attach" {
  role       = var.aws_iam_role
  policy_arn = aws_iam_policy.jenkins_s3_policy.arn
}