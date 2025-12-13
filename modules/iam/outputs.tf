output "builder_access_key" {
  value = aws_iam_access_key.builder_key.id
}

output "builder_access_secret" {
  value     = aws_iam_access_key.builder_key.secret
  sensitive = true
}

output "runner_access_key" {
  value = aws_iam_access_key.runner_key.id
}

output "runner_access_secret" {
  value     = aws_iam_access_key.runner_key.secret
  sensitive = true
}
