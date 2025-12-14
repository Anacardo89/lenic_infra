data "aws_ami" "this" {
  most_recent = true
  owners      = [ "amazon" ]

  filter {
    name   = "name"
    values = [ "al2023-ami-*-x86_64" ]
  }

    tags = {
    Name        = "${ var.project_name }-${ var.environment }-ami"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}