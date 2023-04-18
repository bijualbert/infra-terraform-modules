module "custom_rule" {
  source = "../../../modules/aws/config_custom_rule"

  name       = "${var.project_name}CustomRule"
  source_dir = "${path.module}/src"

  tags = var.tags
}
