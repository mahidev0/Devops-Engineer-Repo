output "artifacts_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.artifacts_bucket.arn
}

output "artifacts_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.artifacts_bucket.id
}