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

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "ec2_keypair_name" {
  type        = string
  description = "Name of the existing AWS key pair for SSH access"
}

variable "ec2_ssh_public_key" {
  type        = string
  description = "SSH Public key for EC2"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_user" {
  type        = string
  description = "Database admin username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Database admin password"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where RDS will reside"
}

variable "ec2_security_group_id" {
  type        = string
  description = "Security group ID for EC2 instances allowed to access RDS"
}
