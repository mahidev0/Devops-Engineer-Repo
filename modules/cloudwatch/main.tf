resource "aws_sns_topic" "alerts" {
  name = "devops-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  for_each = toset(var.instance_ids)

  alarm_name          = "HighCPU-${each.value}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Triggered when CPU > 70%"

  dimensions = {
    InstanceId = each.value
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
}