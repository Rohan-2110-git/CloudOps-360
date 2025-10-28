resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = 14

  tags = { Project = "cloudops-360" }
}
