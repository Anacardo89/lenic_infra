resource "aws_db_subnet_group" "default" {
  name       = lower("${var.project_name}-${var.env}-db-subnet-group")
  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "${var.project_name}-${var.env}-db-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  identifier           = lower("${var.project_name}-${var.env}-postgres")
  username             = var.db_user
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true

  tags = {
    Name = "${var.project_name}-${var.env}-postgres"
  }
}