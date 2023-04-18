resource "aws_iam_role" "this" {
  name               = substr(var.name, 0, 64)
  assume_role_policy = var.assume_role_policy
  tags               = var.tags
}

resource "aws_iam_role_policy" "this" {
  name   = substr(var.name, 0, 64)
  role   = aws_iam_role.this.id
  policy = var.policy
}
