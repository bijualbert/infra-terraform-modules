output "sfn_state_machine" {
  value = aws_sfn_state_machine.this
}

output "aws_iam_role" {
  value = module.iam_role.aws_iam_role
}
output "aws_iam_policy" {
  value = module.iam_role.aws_iam_role_policy
}
