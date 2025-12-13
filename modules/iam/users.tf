# Builder
resource "aws_iam_user" "builder" {
  name = "${var.project_name}-${var.environment}-builder"
  path = "/"

  tags = {
    Name        = "${var.project_name}-${var.environment}-builder"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_user_group_membership" "builder_membership" {
  user = aws_iam_user.builder.name
  groups = [aws_iam_group.builder_group.name]
}

resource "aws_iam_access_key" "builder_key" {
  user = aws_iam_user.builder.name
}

# Runner
resource "aws_iam_user" "runner" {
  name = "${var.project_name}-${var.environment}-runner"
  path = "/"

  tags = {
    Name        = "${var.project_name}-${var.environment}-runner"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_user_group_membership" "runner_membership" {
  user = aws_iam_user.runner.name
  groups = [aws_iam_group.runner_group.name]
}

resource "aws_iam_access_key" "runner_key" {
  user = aws_iam_user.runner.name
}
