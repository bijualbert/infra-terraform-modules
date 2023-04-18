variable "name" {
  description = "Name that should be used for the API Gateway REST API and related resources"
}
variable "path_part" {
  description = "Path part to the default resource that should be created under the root resource of the REST API"
}
variable "tags" {
  description = "Tags that should be applied to all resources in this module"
  type        = map
}
