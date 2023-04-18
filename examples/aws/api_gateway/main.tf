module "api" {
  source = "../../../modules/aws/api_gateway_rest_api"

  name      = "${var.project_name}ApiGateway"
  path_part = "test"

  tags = var.tags
}

module "get_method" {
  source = "../../../modules/aws/api_gateway_method_to_lambda"

  rest_api        = module.api.aws_api_gateway_rest_api
  resource        = module.api.aws_api_gateway_resource
  http_method     = "GET"
  lambda_function = module.lambda_function.aws_lambda_function
}

module "cors" {
  source = "../../../modules/aws/api_gateway_cors"

  rest_api = module.api.aws_api_gateway_rest_api
  resource = module.api.aws_api_gateway_resource
}

module "lambda_function" {
  source = "../../../modules/aws/lambda_function"

  name       = "${var.project_name}LambdaApiGateway"
  source_dir = "${path.module}/src/lambda_function"

  tags = var.tags
}

resource "aws_api_gateway_deployment" "api" {
  depends_on = [
    module.get_method.aws_api_gateway_integration,
    module.cors.aws_api_gateway_integration
  ]

  rest_api_id = module.api.aws_api_gateway_rest_api.id
  stage_name  = "test"
}

# Custom Authorizer

module "api_authorizer" {
  source = "../../../modules/aws/api_gateway_rest_api"

  name      = "${var.project_name}ApiGatewayAuthorizer"
  path_part = "test"

  tags = var.tags
}

module "lambda_function_authorizer" {
  source = "../../../modules/aws/lambda_function"

  name       = "${var.project_name}LambdaApiGatewayAuthorizer"
  source_dir = "${path.module}/src/authorizer"

  tags = var.tags
}

module "authorizer" {
  source = "../../../modules/aws/api_gateway_custom_authorizer"

  name       = "${var.project_name}ApiGatewayAuthorizer"
  rest_api   = module.api_authorizer.aws_api_gateway_rest_api
  authorizer = module.lambda_function_authorizer.aws_lambda_function

  tags = var.tags
}

module "get_method_custom_authorizer" {
  source = "../../../modules/aws/api_gateway_method_to_lambda"

  rest_api        = module.api_authorizer.aws_api_gateway_rest_api
  resource        = module.api_authorizer.aws_api_gateway_resource
  http_method     = "GET"
  lambda_function = module.lambda_function.aws_lambda_function
  authorization   = "CUSTOM"
  authorizer      = module.authorizer.aws_api_gateway_authorizer
}

module "get_method_api_key" {
  source = "../../../modules/aws/api_gateway_method_to_lambda"

  rest_api         = module.api_authorizer.aws_api_gateway_rest_api
  resource         = module.api_authorizer.aws_api_gateway_resource
  http_method      = "POST"
  lambda_function  = module.lambda_function.aws_lambda_function
  api_key_required = true
}

resource "aws_api_gateway_deployment" "api_authorizer" {
  depends_on = [
    module.get_method_custom_authorizer.aws_api_gateway_integration
  ]

  rest_api_id = module.api_authorizer.aws_api_gateway_rest_api.id
  stage_name  = "test"
}
