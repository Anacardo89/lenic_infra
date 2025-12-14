# Auth
variable "aws_terraform_key" {
  type        = string
  description = "Terraform user access Key ID"
}
variable "aws_terraform_secret" {
  type        = string
  description = "Terraform user access Key secret"
}

# Global
variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment (e.g. dev, prod)"
}
variable "aws_region" {
  type        = string
  default     = "eu-west-3"
  description = "AWS region for the deployment"
}
variable "project_name" {
  type        = string
  default     = "lenic"
  description = "Name of the project"
}

# Network
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}
variable "public_subnets" {
  type = list(object({
    cidr = string
    az   = string
  }))
  default = [
    { cidr = "10.0.0.0/25", az = "eu-west-3a" }
  ]
  description = "Public subnets with CIDR and AZ"
}
variable "private_subnets" {
  type = list(object({
    cidr = string
    az   = string
  }))
  default = [
    { cidr = "10.0.0.128/28", az = "eu-west-3a" },
    { cidr = "10.0.0.144/28", az = "eu-west-3b" }
  ]
  description = "Private subnets with CIDR and AZ"
}

# Compute
variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}
variable "ec2_keypair_name" {
  type        = string
  default     = "lenic-ec2-keypair"
  description = "Name of the existing AWS key pair for SSH access"
}
variable "ec2_ssh_public_key" {
  type        = string
  description = "SSH Public key for EC2"
}

# Database
variable "db_name" {
  type        = string
  default     = "lenicDB"
  description = "Database name"
}
variable "db_admin_user" {
  type        = string
  default     = "lenic_admin"
  description = "Database admin username"
}
variable "db_admin_password" {
  type        = string
  sensitive   = true
  description = "Database admin password"
}
variable "db_runner" {
  type        = string
  default     = "lenic_runner"
  description = "Database user for app runtime"
}
variable "db_migrator" {
  type        = string
  default     = "lenic_migrator"
  description = "Database user for migrations"
}