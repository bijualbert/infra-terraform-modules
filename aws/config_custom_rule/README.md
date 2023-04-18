## Module Resources

This Terraform module provisions:

- AWS Config Custom Rule
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
- `timeout` - Timeout for the Lambda function in seconds (Default: `30`)
- `environment` - Environment configuration for the Lambda function
- `vpc_config` - VPC Config for the Lambda function
- `dead_letter_config` - Dead letter configuration for the Lambda function
- `tags` - Tags that should be applied to all resources in this module
- `retention_in_days` - Retention period for log messages in days (Default: `30`)
- `policy_statements` - IAM Policy Statements that should be applied to the Lambda function

## Usage

```hcl
module "custom_rule" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/config_custom_rule?ref="

  name                   = "MyRule"
  source_dir             = "${path.module}/src"

  tags = var.tags
}
```

# Outputs

- `archive_file`
- `aws_lambda_function`
- `aws_cloudwatch_log_group`
- `aws_iam_role`
- `aws_iam_policy`
- `aws_config_config_rule"`
- `aws_lambda_permission`
- `aws_iam_role_policy_attachment`
