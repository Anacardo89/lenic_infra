resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-${var.environment}-s3-configs"
  force_destroy = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-s3-configs"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}