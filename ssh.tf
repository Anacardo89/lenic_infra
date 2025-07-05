resource "aws_key_pair" "deployer" {
  key_name   = "lenic-ec2-key"
  public_key = file(var.ec2_ssh_public_key)
}