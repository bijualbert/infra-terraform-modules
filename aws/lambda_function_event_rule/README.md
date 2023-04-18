## Module Resources

This Terraform module provisions:

- CloudWatch Event Rule
- CloudWatch Event Target
- Lambda function
- CloudWatch Log Group
- IAM Role
- IAM Policy

## Module Input Variables

- `name` - Name that should be used for the Lambda function and related resources
- `source_dir` - Local directory containing the source code for the Lambda Function
- `filename` - ZIP file containing the source code for the Lambda Function
- `handler` - The entrypoint that should be called when the Lambda function is invoked (Default: `lambda_function.lambda_handler`)
- `runtime` - Runtime that should be used for the Lambda function (Default: `python3.7`)
- `layers` - List of Lambda layers that should be attached to the Lambda function
- `memory_size` - Amount of memory that should be configured for the Lambda function
- `timeout` - Timeout for the Lambda function (Default: `30`)
- `environment` - Environment configuration for the Lambda function
- `vpc_config` - VPC Config for the Lambda function
- `dead_letter_config` - Dead letter configuration for the Lambda function
- `tags` - Tags that should be applied to all resources in this module
- `retention_in_days` - Retention period for log messages in days (Default: `30`)
- `policy_statements` - IAM Policy Statements that should be applied to the Lambda function
- `error_actions_enabled` - Whether error alarm actions should be enabled or not (Default: `true`)
- `error_insufficient_data_actions` - Actions that should be performed in case the error alarm is in the insufficient data state (Default: `[]`)
- `error_alarm_actions` - Actions that should be performed in case the error alarm is in the alarm state (Default: `[]`)
- `error_ok_actions` - Actions that should be performed in case the error alarm is in the ok state (Default: `[]`)
- `is_enabled` - Whether the CloudWatch Event Rule should be enabled or not
- `event_pattern` - Event pattern that should be used to trigger the CloudWatch Event Rule
- `schedule_expression` - Scheduled expression that should be used to trigger the CloudWatch Event Rule

## Usage

```hcl
module "event_pattern" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/lambda_function_event_rule?ref="

  name          = "${var.project_name}Lambda"
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
```

```hcl
module "schedule_expression" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/lambda_function_event_rule?ref="

  name                = "${var.project_name}Lambda"
  source_dir          = "${path.module}/src"
  schedule_expression = "cron(0 2 * * ? *)"

  tags = var.tags
}
```

# Outputs

- `archive_file`
- `aws_lambda_function`
- `aws_cloudwatch_log_group`
- `aws_iam_role`
- `aws_iam_policy`
- `aws_cloudwatch_event_rule`
- `aws_cloudwatch_event_target`
- `aws_lambda_permission`
- `aws_cloudwatch_metric_alarm_errors`
