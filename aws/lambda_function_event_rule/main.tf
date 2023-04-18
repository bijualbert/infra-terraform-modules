resource "aws_cloudwatch_event_rule" "this" {
  name                = var.name
  is_enabled          = var.is_enabled
  event_pattern       = var.event_pattern
  schedule_expression = var.schedule_expression
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "this" {
  arn  = module.lambda_function.aws_lambda_function.arn
  rule = aws_cloudwatch_event_rule.this.name
}

resource "aws_lambda_permission" "event_rule_lambda_permission" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.aws_lambda_function.function_name
  principal     = "events.amazonaws.com"
}

module "lambda_function" {
  source = "../lambda_function"

  source_dir                      = var.source_dir
  filename                        = var.filename
  name                            = var.name
  handler                         = var.handler
  runtime                         = var.runtime
  layers                          = var.layers
  memory_size                     = var.memory_size
  timeout                         = var.timeout
  environment                     = var.environment
  vpc_config                      = var.vpc_config
  retention_in_days               = var.retention_in_days
  policy_statements               = var.policy_statements
  error_actions_enabled           = var.error_actions_enabled
  error_insufficient_data_actions = var.error_insufficient_data_actions
  error_alarm_actions             = var.error_alarm_actions
  error_ok_actions                = var.error_ok_actions
  tags                            = var.tags
}
