variable "name" {
  description = "Name that should be used for all resources in this module"
}
variable "assume_role_policy" {
  description = "Assume role policy that should be used for the IAM Role"
}
variable "tags" {
  description = "Tags that should be applied to all resources in this module"
}
variable "policy" {
  description = "IAM Policy that should be attached inline to the IAM Role"
}
