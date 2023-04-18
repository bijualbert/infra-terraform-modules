variable "rest_api" {
  description = "REST API that the method should be associated to"
}
variable "resource" {
  description = "Resource that the method should be associated to"
}
variable "http_method" {
  description = "HTTP method that this method should support"
}
variable "authorization" {
  description = "Authorization type that should be used for this method"
  default     = "NONE"
}
variable "authorizer" {
  description = "Authorizer that should be used to authorize calls to this method"
  default     = null
}
variable "lambda_function" {
  description = "The Lambda function that should be integrated with this method"
}
variable "request_validator" {
  description = "Request Validator that should be used to validate calls to this method"
  default     = null
}
variable "request_parameters" {
  description = "Request parameters supported by this method"
  type        = map
  default     = null
}
variable "request_models" {
  description = "Request models supported by this method"
  type        = map
  default     = null
}
variable "status_code" {
  description = "Success status code that be used by the method response"
  default     = "200"
}
variable "response_model_name" {
  description = "Name of the Model that should be used by the method respose"
  default     = "Empty"
}
variable "api_key_required" {
  description = "Whether an API Key is required to access the method or not"
  default     = null
}
