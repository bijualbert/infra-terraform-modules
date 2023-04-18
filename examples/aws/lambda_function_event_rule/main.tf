module "event_pattern" {
  source = "../../../modules/aws/lambda_function_event_rule"

  name          = "${var.project_name}LambdaEventPattern"
  source_dir    = "${path.module}/src"
  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS Console Sign In via CloudTrail"
  ]
}
PATTERN

  tags = var.tags
}

module "schedule_expression" {
  source = "../../../modules/aws/lambda_function_event_rule"

  name                = "${var.project_name}LambdaScheduleExpression"
  source_dir          = "${path.module}/src"
  schedule_expression = "cron(0 2 * * ? *)"

  tags = var.tags
}
