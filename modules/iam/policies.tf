# Terraform user → admin permissions (temporary for bootstrapping)
resource "aws_iam_policy_attachment" "terraform_attach" {
  name       = "terraform-attach-${var.environment}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  groups     = [aws_iam_group.terraform_group.name]
}

# Builder user → limited permissions for EC2, S3, RDS
resource "aws_iam_policy" "builder_policy" {
  name        = "${var.project_name}-builder-policy-${var.environment}"
  description = "Allows deploying the application"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "ec2:*",
          "s3:*",
          "rds:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "builder_attach" {
  name       = "builder-attach-${var.environment}"
  policy_arn = aws_iam_policy.builder_policy.arn
  groups     = [aws_iam_group.builder_group.name]
}

# Runner user → runtime permissions (e.g., read from S3, connect to RDS)
resource "aws_iam_policy" "runner_policy" {
  name        = "${var.project_name}-runner-policy-${var.environment}"
  description = "Permissions for application runtime"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "rds:*",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "runner_attach" {
  name       = "runner-attach-${var.environment}"
  policy_arn = aws_iam_policy.runner_policy.arn
  groups     = [aws_iam_group.runner_group.name]
}
