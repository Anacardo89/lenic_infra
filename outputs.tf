# IAM
output "builder_access_key" {
  value     = module.iam.builder_access_key
  sensitive = true
}

output "builder_access_secret" {
  value     = module.iam.builder_access_secret
  sensitive = true
}

output "runner_access_key" {
  value     = module.iam.runner_access_key
  sensitive = true
}

output "runner_access_secret" {
  value     = module.iam.runner_access_secret
  sensitive = true
}

# Compute
output "ec2_public_ip" {
  value       = module.compute.ec2_public_ip
  sensitive   = true
  description = "The public IP address of the EC2 instance"
}

output "ec2_public_dns" {
  value       = module.compute.ec2_public_dns
  sensitive   = true
  description = "The public DNS name of the EC2 instance"
}

# Database
output "rds_endpoint" {
  value       = module.database.rds_endpoint
  sensitive   = true
  description = "The connection endpoint for the RDS PostgreSQL instance"
}

output "rds_port" {
  value       = module.database.rds_port
  sensitive   = true
  description = "The port on which the RDS instance is listening"
}

# Storage
output "bucket_name" {
  value       = module.storage.bucket_name
  sensitive   = true
  description = "The bucket name for app configs"
}

output "bucket_arn" {
  value       = module.storage.bucket_arn
  sensitive   = true
  description = "The bucket ARN for app configs"
}
