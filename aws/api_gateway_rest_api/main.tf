resource "aws_api_gateway_rest_api" "this" {
  name = var.name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  tags = var.tags
}

resource "aws_api_gateway_request_validator" "this" {
  name                        = var.name
  rest_api_id                 = aws_api_gateway_rest_api.this.id
  validate_request_body       = true
  validate_request_parameters = true
}

resource "aws_api_gateway_resource" "this" {
  path_part   = var.path_part
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
}
