resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project_name}-${var.env}-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_db_a.id,
    aws_subnet.private_db_b.id
  ]

  tags = {
    Name        = "${var.project_name}-${var.env}-db-subnet-group"
    Project     = var.project_name
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = "db.t2.micro"
  identifier              = "${var.project_name}-${var.env}-postgres"
  username                = var.db_user
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_access.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false
  backup_retention_period = 0

  tags = {
    Name        = "${var.project_name}-${var.env}-postgres"
    Project     = var.project_name
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}