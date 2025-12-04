resource "aws_instance" "lenic_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  subnet_id              = aws_subnet.public_web.id
  vpc_security_group_ids = [
    aws_security_group.ec2_access.id
  ]

  key_name = var.ec2_keypair_name

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
    delete_on_termination = true 
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-server"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}