variable "queue_name" {
  type = string
}

variable "message_retention_seconds" {
  default = "345600"
}

variable "receive_wait_time_seconds" {
  default = "5"
}

variable "visibility_timeout_seconds" {
  default = "30"
}

variable "max_receives_count" {
  default = "50"
}

variable "policy" {}

variable "tags" {
  type = map
}
