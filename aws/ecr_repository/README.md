## Module Resources

This Terraform module provisions:

- ECR Repository
- ECR Repository Policy
- ECR Lifecycle Policy

## Module Input Variables

- `name` - Name that should be used for the ECR Repository and related resources
- `tags` - Tags that should be applied to all resources in this module
- `organization_id` - ID of the organization on AWS Organizations that should have access to the ECR Repository
- `max_number_of_images` - Maximum number of images that should be kept in the ECR Repository (Default: `10`)

## Usage

```hcl
module "ecr_repo" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/ecr_repository?ref="

  name            = "EcrRepository"
  organization_id = "..."

  tags = var.tags
}
```

# Outputs

- `aws_ecr_repository`
- `aws_ecr_repository_policy`
- `aws_ecr_lifecycle_policy`
