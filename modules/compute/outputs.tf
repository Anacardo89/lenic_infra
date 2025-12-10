output "ec2_id" {
  value = aws_instance.this.id
}

output "ec2_public_ip" {
  value = aws_instance.this.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.this.public_dns
}

output "ec2_security_group_id" {
  value = aws_security_group.this.id
}

output "vpc_security_group_ids" {
  value = aws_instance.this.vpc_security_group_ids
}