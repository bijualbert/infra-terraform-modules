output "aws_ecs_task_definition" {
  value = aws_ecs_task_definition.this
}
output "aws_cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.this
}
output "execution_iam_role" {
  value = module.execution_role.aws_iam_role
}
output "execution_iam_policy" {
  value = module.execution_role.aws_iam_role_policy
}
