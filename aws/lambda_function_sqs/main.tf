resource "aws_sqs_queue" "this" {
  name                       = var.name
  delay_seconds              = var.delay_seconds
  policy                     = var.sqs_queue_policy
  visibility_timeout_seconds = var.timeout
  sqs_managed_sse_enabled    = true

  tags = var.tags
}

resource "aws_lambda_event_source_mapping" "this" {
  event_source_arn = aws_sqs_queue.this.arn
  function_name    = module.lambda_function.aws_lambda_function.arn
  batch_size       = var.batch_size
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
  policy_statements = concat(var.policy_statements,
    [
      {
        "Effect" : "Allow",
        "Action" : [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        "Resource" : [
          aws_sqs_queue.this.arn
        ]
      }
    ]
  )
  error_actions_enabled           = var.error_actions_enabled
  error_insufficient_data_actions = var.error_insufficient_data_actions
  error_alarm_actions             = var.error_alarm_actions
  error_ok_actions                = var.error_ok_actions
  tags                            = var.tags
}
