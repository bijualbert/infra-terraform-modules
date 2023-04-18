module "sfn" {
  source = "../../../modules/aws/sfn_state_machine"

  name       = "${var.project_name}Sfn"
  definition = templatefile("${path.module}/templates/definition.json", {})
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
