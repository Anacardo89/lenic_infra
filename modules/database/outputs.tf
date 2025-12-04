output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "rds_port" {
  value = aws_db_instance.postgres.port
}

output "rds_db_name" {
  value = aws_db_instance.postgres.db_name
}

output "rds_username" {
  value = aws_db_instance.postgres.username
}

output "rds_password" {
  value     = aws_db_instance.postgres.password
  sensitive = true
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.name
}