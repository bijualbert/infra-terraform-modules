## Module Resources

This Terraform module provisions:

- API Gateway Method
- API Gateway Method Response
- API Gateway Integration
- API Gateway Integration Response

## Module Input Variables

- `rest_api` - REST API that the method should be associated to
- `resource` - Resource that the method should be associated to

## Usage

```hcl
module "get" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/api_gateway_cors?ref="

  rest_api = module.api.aws_api_gateway_rest_api
  resource = module.api.aws_api_gateway_resource
}
```

# Outputs

- `aws_api_gateway_method`
- `aws_api_gateway_method_response`
- `aws_api_gateway_integration`
- `aws_api_gateway_integration_response`
