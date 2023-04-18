## Module Resources

This Terraform module provisions:

- API Gateway Method
- API Gateway Method Response
- API Gateway Method Response (HTTP_400)
- API Gateway Integration
- AWS Lambda Permission

## Module Input Variables

- `rest_api` - REST API that the method should be associated to
- `resource` - Resource that the method should be associated to
- `http_method` - HTTP method that this method should support
- `authorization` - Authorization type that should be used for this method (Default: `NONE`)
- `authorizer` - Authorizer that should be used to authorize calls to this method
- `lambda_function` - The Lambda function that should be integrated with this method
- `request_validator` - Request Validator that should be used to validate calls to this method
- `request_parameters` - Request parameters supported by this method
- `request_models` - Request models supported by this method
- `status_code` - Success status code that be used by the method response (Default: `200`)
- `response_model_name` - Name of the Model that should be used by the method respose (Default: `Empty`)
- `api_key_required` - Whether an API Key is required to access the method or not

## Usage

```hcl
module "get" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/api_gateway_method_to_lambda?ref="

  rest_api        = module.api.aws_api_gateway_rest_api
  resource        = module.api.aws_api_gateway_resource
  http_method     = "GET"
  lambda_function = module.lambda_function.aws_lambda_function
}
```

```hcl
module "get_with_cors" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/api_gateway_method_to_lambda?ref="

  rest_api        = module.api.aws_api_gateway_rest_api
  resource        = module.api.aws_api_gateway_resource
  http_method     = "GET"
  lambda_function = module.lambda_function.aws_lambda_function
}
```

```hcl
module "get_with_authorizer" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/api_gateway_method_to_lambda?ref="

  rest_api        = module.api.aws_api_gateway_rest_api
  resource        = module.api.aws_api_gateway_resource
  http_method     = "GET"
  lambda_function = module.lambda_function.aws_lambda_function
  authorization   = "CUSTOM"
  authorizer      = module.authorizer.aws_api_gateway_authorizer
}
```

# Outputs

- `aws_api_gateway_method`
- `aws_api_gateway_method_response`
- `aws_api_gateway_method_response_http_400`
- `aws_api_gateway_integration`
- `aws_lambda_permission`
