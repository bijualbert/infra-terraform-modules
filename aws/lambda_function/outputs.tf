output "archive_file" {
  value = data.archive_file.this
}
output "aws_lambda_function" {
  value = aws_lambda_function.this
}
output "aws_cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.this
}
output "aws_iam_role" {
  value = module.iam_role.aws_iam_role
}
output "aws_iam_policy" {
  value = module.iam_role.aws_iam_role_policy
}
output "aws_cloudwatch_metric_alarm_errors" {
  value = aws_cloudwatch_metric_alarm.errors
}
