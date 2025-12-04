output "config_bucket_name" {
  value = aws_s3_bucket.lenic_config.bucket
}

output "config_bucket_arn" {
  value = aws_s3_bucket.lenic_config.arn
}
