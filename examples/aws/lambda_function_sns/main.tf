module "lambda_sns" {
  source = "../../../modules/aws/lambda_function_sns"

  name       = "${var.project_name}LambdaSns"
  source_dir = "${path.module}/src"

  tags = var.tags
}
