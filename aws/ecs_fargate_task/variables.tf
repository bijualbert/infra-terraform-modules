variable "family" {
  description = "Name that should be used for the ECS task Definition and related resources"
}
variable "container_definitions" {
  description = "List of container definition that should be used by the ECS task"
}
variable "task_role" {
  description = "The IAM Role that should be used by the ECS task"
  default     = null
}
variable "cpu" {
  description = "CPU units that will be used by the ECS task"
  default     = "256"
}
variable "memory" {
  description = "The amount (in MiB) of memory that can be used by the ECS task"
  default     = "512"
}
variable "tags" {
  description = "Tags that should be applied to all resources in this module"
}
variable "retention_in_days" {
  description = "Retention period for log messages in days"
  default     = 30
}
