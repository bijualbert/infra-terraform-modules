## Module Resources

This Terraform module provisions:

- IAM Role
- IAM Policy

## Module Input Variables

- `name` - Name that should be used for all resources in this module
- `assume_role_policy` - Assume role policy that should be used for the IAM Role
- `tags` - Tags that should be applied to all resources in this module
- `policy` - IAM Policy that should be attached inline to the IAM Role]

## Usage

```hcl
module "iam_role" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/iam_role_with_policy?ref="

  name               = var.name
  assume_role_policy = templatefile("${path.module}/templates/assume_role_policy.json", {})
  policy             = templatefile("${path.module}/templates/policy.tpl", {})

  tags = var.tags
}
```

# Outputs

- `aws_iam_role`
- `aws_iam_role_policy`
