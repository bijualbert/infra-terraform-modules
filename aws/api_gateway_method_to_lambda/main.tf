resource "aws_api_gateway_method" "this" {
  rest_api_id          = var.rest_api.id
  resource_id          = var.resource.id
  http_method          = var.http_method
  authorization        = var.authorization
  authorizer_id        = local.authorizer_id
  api_key_required     = var.api_key_required
  request_validator_id = var.request_validator != null ? var.request_validator.id : null
  request_parameters   = var.request_parameters
  request_models       = var.request_models
}

resource "aws_api_gateway_method_response" "this" {
  rest_api_id = var.rest_api.id
  resource_id = var.resource.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = var.status_code
  response_models = {
    "application/json" = var.response_model_name
  }
  depends_on = [aws_api_gateway_method.this]
}

resource "aws_api_gateway_method_response" "http_400" {
  rest_api_id = var.rest_api.id
  resource_id = var.resource.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = "400"
  response_models = {
    "application/json" = "Error"
  }
  depends_on = [aws_api_gateway_method.this]
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id             = var.rest_api.id
  resource_id             = var.resource.id
  http_method             = aws_api_gateway_method.this.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function.invoke_arn
}

resource "aws_lambda_permission" "this" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.rest_api.execution_arn}/*/*/*"
}
