provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "this" {
  bucket = "${ var.project_name }-${ var.environment }-terraform-state"
  force_destroy = true

  tags = {
    Name        = "${ var.project_name }-${ var.environment }-terraform-state"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_dynamodb_table" "this" {
  name         = "${ var.project_name }-${ var.environment }-terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${ var.project_name }-${ var.environment }-terraform-lock"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}