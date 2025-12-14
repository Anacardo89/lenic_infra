resource "aws_default_network_acl" "this" {
  default_network_acl_id = aws_vpc.this.default_network_acl_id

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name        = "${ var.project_name }-${ var.environment }-default-nacl"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_network_acl_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  network_acl_id = aws_default_network_acl.this.id
}

resource "aws_network_acl_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  network_acl_id = aws_default_network_acl.this.id
}