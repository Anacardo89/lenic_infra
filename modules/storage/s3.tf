resource "aws_s3_bucket" "this" {
  bucket = "${ var.project_name }-${ var.environment }-configs"
  force_destroy = true

  tags = {
    Name        = "${ var.project_name }-${ var.environment }-configs"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}