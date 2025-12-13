resource "aws_iam_group" "builder_group" {
  name = "${var.project_name}-builder-${var.environment}"
}

resource "aws_iam_group" "runner_group" {
  name = "${var.project_name}-runner-${var.environment}"
}