variable "name" {
  description = "Name that should be used for the ECR Repository and related resources"
}
variable "tags" {
  description = "Tags that should be applied to all resources in this module"
}
variable "organization_id" {
  description = "ID of the organization on AWS Organizations that should have access to the ECR Repository"
}
variable "max_number_of_images" {
  description = "Maximum number of images that should be kept in the ECR Repository"
  default     = 10
}
