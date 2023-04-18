resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  container_definitions    = var.container_definitions
  task_role_arn            = var.task_role != null ? var.task_role.arn : null
  execution_role_arn       = module.execution_role.aws_iam_role.arn
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = ["FARGATE"]

  tags = var.tags
}

module "execution_role" {
  source = "../iam_role_with_policy"

  name               = "${var.family}ExecutionRole"
  assume_role_policy = templatefile("${path.module}/templates/assume_role_policy.json", {})
  policy = templatefile("${path.module}/templates/policy.tpl", {
    policy_statements = [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        "Resource" : ["*"]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : ["*"]
      }
    ]
  })

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.family}"
  retention_in_days = var.retention_in_days
  tags              = var.tags
}
