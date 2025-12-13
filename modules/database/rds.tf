resource "aws_db_instance" "this" {
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "17.5"
  instance_class          = "db.t3.micro"
  identifier              = "${var.project_name}-${var.environment}-rds"
  db_name                 = "${var.db_name}"
  username                = var.db_user
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  backup_retention_period = 0

  iam_database_authentication_enabled = true
  storage_encrypted                   = true
  skip_final_snapshot                 = true
  publicly_accessible                 = false
  multi_az                            = false
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-rds"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}