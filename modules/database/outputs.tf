output "rds_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "rds_port" {
  value = aws_db_instance.this.port
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.this.name
}