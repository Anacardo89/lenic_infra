terraform {
  backend "s3" {
    bucket         = "${var.project_name}-${var.environment}-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "${var.project_name}-${var.environment}-terraform-lock"
    encrypt        = true
  }
}
