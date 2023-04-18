resource "aws_sfn_state_machine" "this" {
  name       = var.name
  definition = var.definition
  role_arn   = module.iam_role.aws_iam_role.arn
  tags       = var.tags
}

module "iam_role" {
  source = "../iam_role_with_policy"

  name               = var.name
  assume_role_policy = templatefile("${path.module}/templates/assume_role_policy.json", {})
  policy = templatefile("${path.module}/templates/policy.tpl", {
    policy_statements = var.policy_statements
  })

  tags = var.tags
}
