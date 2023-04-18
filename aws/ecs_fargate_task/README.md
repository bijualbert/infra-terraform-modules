## Module Resources

This Terraform module provisions:

- ECS Fargate Task Definition
- CloudWatch Log Group
- Execution IAM Role
- Execution IAM Policy

## Module Input Variables

- `family` - Name that should be used for the ECS task Definition and related resources
- `container_definitions` - List of container definition that should be used by the ECS task
- `task_role` - The IAM Role that should be used by the ECS task
- `cpu` - CPU units that will be used by the ECS task (Default: `256`)
- `memory` - The amount (in MiB) of memory that can be used by the ECS task (Default: `512`)
- `tags` - Tags that should be applied to all resources in this module
- `retention_in_days` - Retention period for log messages in days (Default: `30`)

## Usage

```hcl
module "ecs_fargate_task" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/ecs_fargate_task?ref="

  family                = "EcsFargateTask"
  container_definitions = [...]

  tags = var.tags
}
```

```hcl
module "ecs_fargate_task_extra_permissions" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/ecs_fargate_task?ref="

  family                = "EcsFargateTask"
  container_definitions = templatefile("${path.module}/templates/container_definition.json", {})
  task_role             = module.task_role.aws_iam_role

  tags = var.tags
}
```

# Outputs

- `aws_ecs_task_definition`
- `aws_cloudwatch_log_group`
- `execution_iam_role`
- `execution_iam_policy`
