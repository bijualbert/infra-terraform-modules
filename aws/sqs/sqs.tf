resource "aws_sqs_queue" "sqs_queue" {
  name                       = "${var.queue_name}"
  message_retention_seconds  = "${var.message_retention_seconds}"
  receive_wait_time_seconds  = "${var.receive_wait_time_seconds}"
  visibility_timeout_seconds = "${var.visibility_timeout_seconds}"
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.sqs_error_queue.arn}\",\"maxReceiveCount\":${var.max_receives_count}}"
  sqs_managed_sse_enabled    = true
  
  tags = "${var.tags}"
}

resource "aws_sqs_queue_policy" "sqs_sns_policy" {
  queue_url = "${aws_sqs_queue.sqs_queue.id}"

  policy = "${var.policy}"
}

resource "aws_sqs_queue" "sqs_error_queue" {
  name                      = "${var.queue_name}-ERROR"
  message_retention_seconds = 1209600
  sqs_managed_sse_enabled   = true
}

output "sqs_queue_url" {
  value = "${aws_sqs_queue.sqs_queue.id}"
}

output "sqs_queue_arn" {
  value = "${aws_sqs_queue.sqs_queue.arn}"
}
