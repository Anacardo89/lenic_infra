resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [ aws_security_group.this.id ]

  key_name = aws_key_pair.this.key_name

  iam_instance_profile = aws_iam_instance_profile.this.name

  root_block_device {
    volume_size           = 30
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name        = "${ var.project_name }-${ var.environment }-ec2"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_instance_profile" "this" {
  name = "${ var.project_name }-${ var.environment }-ec2-profile"
  role = var.runner_role_name
}