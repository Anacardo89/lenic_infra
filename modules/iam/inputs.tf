data "aws_caller_identity" "current" {}

variable "environment"         { type = string }
variable "aws_region"          { type = string }
variable "project_name"        { type = string }
variable "rds_dbi_resource_id" { type = string }
variable "db_runner"           { type = string }
variable "db_migrator"         { type = string }