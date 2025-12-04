output "terraform_user_access_key_id" {
  value = aws_iam_access_key.terraform_key.id
}

output "terraform_user_secret_access_key" {
  value     = aws_iam_access_key.terraform_key.secret
  sensitive = true
}

output "builder_user_access_key_id" {
  value = aws_iam_access_key.builder_key.id
}

output "builder_user_secret_access_key" {
  value     = aws_iam_access_key.builder_key.secret
  sensitive = true
}

output "runner_user_access_key_id" {
  value = aws_iam_access_key.runner_key.id
}

output "runner_user_secret_access_key" {
  value     = aws_iam_access_key.runner_key.secret
  sensitive = true
}
