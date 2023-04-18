variable "name" {
  description = "Name that should be used for the API Gateway REST API and related resources"
}
variable "rest_api" {
  description = "REST API that the method should be associated to"
}
variable "authorizer_result_ttl_in_seconds" {
  description = "TTL for cached responses from the Authorizer"
  default     = 0
}
variable "authorizer" {
  description = "The Lambda function that should be used as a Custom Authorizer"
  default     = null
}
variable "tags" {
  description = "Tags that should be applied to all resources in this module"
  type        = map
}
