resource "aws_security_group" "this" {
  name        = "${ var.project_name }-${ var.environment }-rds-sg"
  description = "Allow Postgres access from EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Postgres from EC2"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [ var.ec2_security_group_id ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name        = "${ var.project_name }-${ var.environment }-rds-sg"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}