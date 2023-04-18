output "aws_api_gateway_authorizer" {
  value = aws_api_gateway_authorizer.this
}
output "aws_iam_role" {
  value = module.iam_role.aws_iam_role
}
output "aws_iam_policy" {
  value = module.iam_role.aws_iam_role_policy
}
