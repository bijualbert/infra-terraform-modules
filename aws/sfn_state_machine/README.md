## Module Resources

This Terraform module provisions:

- Step Functions State Machine
- IAM Role
- IAM Policy

## Module Input Variables

- `name` - Name that should be used for the Step Functions State Machine and related resources
- `definition` - State machine defition that should be used by Step Functions
- `tags` - Tags that should be applied to all resources in this module
- `policy_statements` - IAM Policy Statements that should be applied to the Step Functions State Machine

## Usage

```hcl
module "sfn" {
  source = "git::https://github.com/albumprinter/infra-terraform-modules.git//modules/aws/sfn_state_machine?ref="

  name       = "${var.project_name}Lambda"
  definition = "..."
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
```

# Outputs

- `sfn_state_machine`
- `aws_iam_role`
- `aws_iam_policy`
