# IAM
output "deployer_arn" {
  value     = module.iam.deployer_arn
  sensitive = true
}
output "runner_arn" {
  value     = module.iam.runner_arn
  sensitive = true
}

# Compute
output "ec2_public_ip" {
  value       = module.compute.ec2_public_ip
  sensitive   = true
}
output "ec2_public_dns" {
  value       = module.compute.ec2_public_dns
  sensitive   = true
}

# Database
output "rds_endpoint" {
  value       = module.database.rds_endpoint
  sensitive   = true
}
output "rds_port" {
  value       = module.database.rds_port
  sensitive   = true
}

# Storage
output "config_bucket_name" {
  value       = module.storage.config_bucket_name
  sensitive   = true
}
output "config_bucket_arn" {
  value       = module.storage.config_bucket_arn
  sensitive   = true
}
