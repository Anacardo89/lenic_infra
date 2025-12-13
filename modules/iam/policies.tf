resource "aws_iam_policy" "deployer_policy" {
  name        = "${var.project_name}-${var.environment}-deployer-policy"
  description = "Permissions for app deployment"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:PutObject"]
        Resource = "arn:aws:s3:::${var.project_name}-${var.environment}-configs/*"
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-deployer-policy"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_policy" "runner_policy" {
  name        = "${var.project_name}-${var.environment}-runner-policy"
  description = "Permissions for app runtime"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rds-db:connect"
        ]
        Resource = "arn:aws:rds-db:${var.aws_region}:${data.aws_caller_identity.current.account_id}:dbuser:${var.rds_dbi_resource_id}/${var.db_user}"
      },
      {
        Effect = "Allow"
        Action = ["s3:GetObject"]
        Resource = "arn:aws:s3:::${var.project_name}-${var.environment}-configs/*"
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-runner-policy"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
