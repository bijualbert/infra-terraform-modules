data "archive_file" "source_code" {
  type        = "zip"
  output_path = "lambda.zip"
  source {
    content  = "1"
    filename = "source_code.txt"
  }
}

data "aws_vpc" "shared_vpc" {
  tags = {
    Name = "sandbox_vpc"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared_vpc.id]
  }
  tags = {
    Name = "private-*"
  }
}

resource "aws_security_group" "this" {
  name   = "LambdaExample"
  vpc_id = data.aws_vpc.shared_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}



module "lambda_function" {
  source = "../../../modules/aws/lambda_function"

  name       = "${var.project_name}Lambda"
  source_dir = "${path.module}/src"

  tags = var.tags
}

module "lambda_function_policy_statements" {
  source = "../../../modules/aws/lambda_function"

  name       = "${var.project_name}LambdaPolicyStatements"
  filename   = data.archive_file.source_code.output_path
  policy_statements = [
    {
      "Effect" : "Deny",
      "Action" : [
        "s3:ListBucket"
      ],
      "Resource" : ["*"]
    }
  ]

  tags = var.tags
}

module "lambda_function_vpc" {
  source = "../../../modules/aws/lambda_function"
 
  name       = "${var.project_name}LambdaVpc"
  source_dir = "${path.module}/src"
  vpc_config = {
    subnet_ids         = data.aws_subnets.private.ids,
    security_group_ids = [aws_security_group.this.id]
  }
 
  tags = var.tags
}

module "lambda_function_environment" {
  source = "../../../modules/aws/lambda_function"

  name       = "${var.project_name}LambdaEnvironment"
  source_dir = "${path.module}/src"
  environment = {
    variables = {
      TEST = "test"
    }
  }
  error_actions_enabled = "false"

  tags = var.tags
}

resource "aws_sns_topic" "lambda_errors" {
  name = "${var.project_name}LambdaErrors"
}

module "lambda_function_alarm" {
  source = "../../../modules/aws/lambda_function"

  name       = "${var.project_name}LambdaErrorAlarm"
  source_dir = "${path.module}/src"
  environment = {
    variables = {
      TEST = "test"
    }
  }
  error_alarm_actions = [aws_sns_topic.lambda_errors.arn]

  tags = var.tags
}

resource "aws_sqs_queue" "dead_letter" {
  name = "${var.project_name}DeadLetter"
  sqs_managed_sse_enabled = true
}

module "lambda_function_dead_letter" {
  source = "../../../modules/aws/lambda_function"

  name       = "${var.project_name}DeadLetter"
  filename   = data.archive_file.source_code.output_path

  dead_letter_config = {
    target_arn = aws_sqs_queue.dead_letter.arn
  }

  tags = var.tags
}
