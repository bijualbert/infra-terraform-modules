module "ecs_fargate_task" {
  source = "../../../modules/aws/ecs_fargate_task"

  family = "${var.project_name}EcsFargateTask"
  container_definitions = templatefile("${path.module}/templates/container_definition.json", {
    family = "EcsFargateTask"
  })

  tags = var.tags
}

module "iam_role" {
  source = "../../../modules/aws/iam_role_with_policy"

  name               = "${var.project_name}EcsFargateTaskExtraPermissionsTask"
  assume_role_policy = templatefile("${path.module}/templates/assume_role_policy.json", {})
  policy             = templatefile("${path.module}/templates/policy.json", {})

  tags = var.tags
}

module "ecs_fargate_task_extra_permissions" {
  source = "../../../modules/aws/ecs_fargate_task"

  family = "${var.project_name}EcsFargateTaskExtraPermissions"
  container_definitions = templatefile("${path.module}/templates/container_definition.json", {
    family = "EcsFargateTask"
  })
  task_role = module.iam_role.aws_iam_role

  tags = var.tags
}
