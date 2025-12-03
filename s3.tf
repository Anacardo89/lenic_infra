resource "aws_s3_bucket" "lenic_config" {
  bucket = "lenic-app-configs"
  
  tags = {
    Name        = "${var.project_name}-${var.env}-lenic-config-bucket"
    Project     = var.project_name
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_policy" "lenic_config_policy" {
  bucket = aws_s3_bucket.lenic_config.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.lenic_app_role.arn
        }
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.lenic_config.arn}/*"
      }
    ]
  })
}