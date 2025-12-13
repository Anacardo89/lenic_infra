# IAM
output "terraform_user_access_key_id" {
  value = module.iam.terraform_user_access_key_id
}

output "terraform_user_secret_access_key" {
  value     = module.iam.terraform_user_secret_access_key
  sensitive = true
}

output "builder_user_access_key_id" {
  value = module.iam.builder_user_access_key_id
}

output "builder_user_secret_access_key" {
  value     = module.iam.builder_user_secret_access_key
  sensitive = true
}

output "runner_user_access_key_id" {
  value = module.iam.runner_user_access_key_id
}

output "runner_user_secret_access_key" {
  value     = module.iam.runner_user_secret_access_key
  sensitive = true
}

# Compute
output "ec2_id" {
  value       = module.compute.ec2_id
  description = "The ID of the EC2 instance"
}

output "ec2_public_ip" {
  value       = module.compute.ec2_public_ip
  description = "The public IP address of the EC2 instance"
}

output "ec2_public_dns" {
  value       = module.compute.public_dns
  description = "The public DNS name of the EC2 instance"
}

# Database
output "rds_endpoint" {
  value       = module.database.rds_endpoint
  description = "The connection endpoint for the RDS PostgreSQL instance"
}

output "rds_port" {
  value       = module.database.rds_port
  description = "The port on which the RDS instance is listening"
}

# Storage
output "bucket_name" {
  value = module.storage.bucket_name
  description = "The bucket name for app configs"
}

output "bucket_arn" {
  value = module.storage.bucket_arn
  description = "The bucket ARN for app configs"
}
