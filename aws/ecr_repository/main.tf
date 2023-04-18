resource "aws_ecr_repository" "this" {
  name = var.name
  tags = var.tags
}

resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.repo.name
  policy     = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "Organization",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "ecr:BatchGetImage",
        "ecr:DescribeImages",
        "ecr:GetDownloadUrlForLayer",
        "ecr:ListImages"
      ],
      "Condition": {
        "StringEquals": {
          "aws:PrincipalOrgID": "${var.organization_id}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.repo.name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keeps only a limited number of images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.max_number_of_images}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

