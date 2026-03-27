variable "instance_ids" {
  description = "EC2 instances to monitor"
  type        = list(string)
}

variable "alarm_email" {
  description = "Email for alerts"
  type        = string
}