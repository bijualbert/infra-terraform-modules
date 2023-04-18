module "lambda_sqs" {
  source = "../../../modules/aws/lambda_function_sqs"

  name       = "${var.project_name}LambdaSqs"
  source_dir = "${path.module}/src"

  tags = var.tags
}

module "lambda_sqs_policy" {
  source = "../../../modules/aws/lambda_function_sqs"

  name             = "${var.project_name}LambdaSqsPolicy"
  source_dir       = "${path.module}/src"
  sqs_queue_policy = templatefile("${path.module}/templates/queue_policy.json", {})

  tags = var.tags
}
