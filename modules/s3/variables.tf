# Base name of the S3 bucket
variable "bucket_name" {
  description = "The base name of the S3 bucket. Must be globally unique."
  type        = string
}

# Enable versioning (default: true)
variable "enable_versioning" {
  description = "Enable versioning on the S3 bucket"
  type        = bool
  default     = true
}

# Optional tags for the bucket
variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}

# Optional ACL (default: private)
variable "acl" {
  description = "The S3 bucket ACL"
  type        = string
  default     = "private"
}

variable "aws_iam_role" {
  description = "IAM role to attach S3 policy"
  type        = string
}

