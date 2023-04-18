## Module Resources

This Terraform module provisions:

- API Gateway Authorizer
- IAM Role
- AWS Policy

## Module Input Variables

- `name` - Name that should be used for the API Gateway REST API and related resources
- `rest_api` - REST API that the method should be associated to
- `authorizer_result_ttl_in_seconds` - TTL for cached responses from the Authorizer (Default: `0`)
- `authorizer` - The Lambda function that should be used as a Custom Authorizer
- `tags` - Tags that should be applied to all resources in this module

## Usage

```hcl
module "get" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/api_gateway_custom_authorizer?ref="

  name       = "${var.project_name}ApiGatewayAuthorizer"
  rest_api   = module.api_authorizer.aws_api_gateway_rest_api
  authorizer = module.lambda_function_authorizer.aws_lambda_function

  tags = var.tags
}
```

# Outputs

- `aws_api_gateway_authorizer`
- `aws_iam_role`
- `aws_iam_policy`
