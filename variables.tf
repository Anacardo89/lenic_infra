variable "aws_region" {
  type        = string
  description = "AWS region for the deployment"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "env" {
  type        = string
  description = "Deployment environment (e.g. dev, prod)"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}