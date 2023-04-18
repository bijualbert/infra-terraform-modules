resource "aws_config_config_rule" "this" {
  name = var.name
  source {
    owner             = "CUSTOM_LAMBDA"
    source_identifier = module.lambda_function.aws_lambda_function.arn

    source_detail {
      event_source = "aws.config"
      message_type = "ConfigurationItemChangeNotification"
    }
  }
}

resource "aws_lambda_permission" "this" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.aws_lambda_function.arn
  principal     = "config.amazonaws.com"
  statement_id  = "AllowExecutionFromConfig"
}

module "lambda_function" {
  source = "../lambda_function"

  source_dir        = var.source_dir
  filename          = var.filename
  name              = var.name
  handler           = var.handler
  runtime           = var.runtime
  layers            = var.layers
  memory_size       = var.memory_size
  timeout           = var.timeout
  environment       = var.environment
  vpc_config        = var.vpc_config
  retention_in_days = var.retention_in_days
  policy_statements = var.policy_statements
  tags              = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = module.lambda_function.aws_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRulesExecutionRole"
}
