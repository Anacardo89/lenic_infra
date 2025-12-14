resource "aws_db_subnet_group" "this" {
  name       = "${ var.project_name }-${ var.environment }-rds-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name        = "${ var.project_name }-${ var.environment }-rds-subnet-group"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
