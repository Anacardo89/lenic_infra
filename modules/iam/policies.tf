# Builder user
resource "aws_iam_policy" "builder_policy" {
  name        = "${var.project_name}-${var.environment}-builder-policy"
  description = "CI/CD deployment permissions"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags"
        ]
        Resource = "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:PutObject"
        ],
        "Resource": "arn:aws:s3:::your-bucket-name/*"
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-builder-policy"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_policy_attachment" "builder_attach" {
  name       = "builder-attach-${var.environment}"
  policy_arn = aws_iam_policy.builder_policy.arn
  groups     = [aws_iam_group.builder_group.name]
}

# Runnser user
resource "aws_iam_policy" "runner_policy" {
  name        = "${var.project_name}-${var.environment}-runner-policy"
  description = "Application runtime permissions"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
          "rds-db:connect"
        ],
        "Resource": "arn:aws:rds-db:region:account-id:dbuser:dbi-resource-id/db-username"
      },
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject"
        ]
        Resource = "*"
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


resource "aws_iam_policy_attachment" "runner_attach" {
  name       = "runner-attach-${var.environment}"
  policy_arn = aws_iam_policy.runner_policy.arn
  groups     = [aws_iam_group.runner_group.name]
}
