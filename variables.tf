variable "env" {
  type        = string
  description = "Deployment environment (e.g. dev, prod)"
}

variable "aws_region" {
  type        = string
  description = "AWS region for the deployment"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ec2_keypair_name" {
  description = "Name of the existing AWS key pair for SSH access"
  type        = string
}

variable "ec2_ssh_public_key" {
  type        = string
  description = "SSH Public key for EC2"
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_user" {
  description = "Database admin username"
  type        = string
}

variable "db_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}
