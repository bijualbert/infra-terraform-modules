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
output "aws_config_config_rule" {
  value = aws_config_config_rule.this
}
output "aws_lambda_permission" {
  value = aws_lambda_permission.this
}
output "aws_iam_role_policy_attachment" {
  value = aws_iam_role_policy_attachment.this
}
