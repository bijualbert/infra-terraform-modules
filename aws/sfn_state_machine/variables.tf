variable "name" {
  description = "Name that should be used for the Step Functions State Machine and related resources"
}
variable "definition" {
  description = "State machine definition that should be used by Step Functions"
}
variable "tags" {
  description = "Tags that should be applied to all resources in this module"
}
variable "policy_statements" {
  description = "IAM Policy Statements that should be applied to the Step Functions State Machine"
}
