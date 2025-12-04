# Terraform
resource "aws_iam_user" "terraform_user" {
  name = "terraform-${var.environment}"
  path = "/"
}

resource "aws_iam_user_group_membership" "terraform_membership" {
  user = aws_iam_user.terraform_user.name
  groups = [aws_iam_group.terraform_group.name]
}

resource "aws_iam_access_key" "terraform_key" {
  user = aws_iam_user.terraform_user.name
}

# Builder
resource "aws_iam_user" "builder_user" {
  name = "${var.project_name}-builder-${var.environment}"
  path = "/"
}

resource "aws_iam_user_group_membership" "builder_membership" {
  user = aws_iam_user.builder_user.name
  groups = [aws_iam_group.builder_group.name]
}

resource "aws_iam_access_key" "builder_key" {
  user = aws_iam_user.builder_user.name
}

# Runner
resource "aws_iam_user" "runner_user" {
  name = "${var.project_name}-runner-${var.environment}"
  path = "/"
}

resource "aws_iam_user_group_membership" "runner_membership" {
  user = aws_iam_user.runner_user.name
  groups = [aws_iam_group.runner_group.name]
}

resource "aws_iam_access_key" "runner_key" {
  user = aws_iam_user.runner_user.name
}
