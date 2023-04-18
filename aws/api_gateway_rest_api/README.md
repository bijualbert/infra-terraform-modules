## Module Resources

This Terraform module provisions:

- API Gateway REST API
- API Gateway Request Validator
- API Gateway Resource

## Module Input Variables

- `name` - Name that should be used for the API Gateway REST API and related resources
- `path_part` - Path part to the default resource that should be created under the root resource of the REST API
- `tags` - Tags that should be applied to all resources in this module

## Usage

```hcl
module "api" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/api_gateway_rest_api?ref="

  name      = "${var.project_name}Api"
  path_part = "prod"

  tags = var.tags
}
```

# Outputs

- `aws_api_gateway_rest_api`
- `aws_api_gateway_request_validator`
- `aws_api_gateway_resource`
