output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = [for s in aws_subnet.public : s.id]
  description = "IDs of public subnets"
}

output "private_subnet_ids" {
  value       = [for s in aws_subnet.private : s.id]
  description = "IDs of private subnets"
}

output "igw_id" {
  value       = aws_internet_gateway.this.id
  description = "Internet Gateway ID"
}

output "route_table_public_id" {
  value       = aws_route_table.public.id
  description = "Public route table ID"
}
