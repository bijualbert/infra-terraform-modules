resource "aws_api_gateway_authorizer" "this" {
  name                             = "${var.name}Authorizer"
  rest_api_id                      = var.rest_api.id
  authorizer_uri                   = var.authorizer.invoke_arn
  authorizer_credentials           = module.iam_role.aws_iam_role.arn
  authorizer_result_ttl_in_seconds = var.authorizer_result_ttl_in_seconds
}

module "iam_role" {
  source = "../iam_role_with_policy"

  name               = "${var.name}Authorizer"
  assume_role_policy = templatefile("${path.module}/templates/assume_role_policy.json", {})
  policy = templatefile("${path.module}/templates/policy.json", {
    authorizer_arn = var.authorizer.arn
  })

  tags = var.tags
}
