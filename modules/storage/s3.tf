resource "aws_s3_bucket" "lenic_config" {
  bucket = "${var.project_name}-${var.environment}-configs"
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-config-bucket"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
