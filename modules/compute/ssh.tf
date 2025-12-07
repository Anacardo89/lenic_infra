resource "aws_key_pair" "this" {
  key_name   = var.ec2_keypair_name
  public_key = var.ec2_ssh_public_key
}