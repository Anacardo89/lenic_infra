resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-${var.env}-rt-public"
    Project     = var.project_name
    Environment = var.env
    ManagedBy   = "Terraform"
    Tier        = "Public"
  }
}

resource "aws_route" "rt_public_igw_route" {
  route_table_id         = aws_route_table.rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "rt_assoc_public_web" {
  subnet_id      = aws_subnet.public_web.id
  route_table_id = aws_route_table.rt_public.id
}