output "aws_sns_topic" {
  value = aws_sns_topic.this
}
output "aws_sns_topic_subscription" {
  value = aws_sns_topic_subscription.this
}
output "aws_lambda_permission" {
  value = aws_lambda_permission.event_rule_lambda_permission
}
output "archive_file" {
  value = module.lambda_function.archive_file
}
output "aws_lambda_function" {
  value = module.lambda_function.aws_lambda_function
}
output "aws_cloudwatch_log_group" {
  value = module.lambda_function.aws_cloudwatch_log_group
}
output "aws_iam_role" {
  value = module.lambda_function.aws_iam_role
}
output "aws_iam_policy" {
  value = module.lambda_function.aws_iam_policy
}
output "aws_cloudwatch_metric_alarm_errors" {
  value = module.lambda_function.aws_cloudwatch_metric_alarm_errors
}
