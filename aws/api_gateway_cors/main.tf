resource "aws_api_gateway_method" "this" {
  rest_api_id   = var.rest_api.id
  resource_id   = var.resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "this" {
  rest_api_id = var.rest_api.id
  resource_id = var.resource.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin"  = false
  }
  depends_on = [aws_api_gateway_method.this]
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id          = var.rest_api.id
  resource_id          = var.resource.id
  http_method          = aws_api_gateway_method.this.http_method
  passthrough_behavior = "NEVER"
  type                 = "MOCK"

  request_templates = {
    "application/json" = <<EOF
{
   "statusCode": 200
}
EOF
  }
}

resource "aws_api_gateway_integration_response" "this" {
  rest_api_id = var.rest_api.id
  resource_id = var.resource.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = aws_api_gateway_method_response.this.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT,DELETE'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [aws_api_gateway_integration.this]
}
