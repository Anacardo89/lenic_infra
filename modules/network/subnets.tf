resource "aws_subnet" "public" {
  for_each = { for idx, subnet in var.public_subnets : idx => subnet }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name        = "${ var.project_name }-${ var.environment }-subnet-public-${ each.key }"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tier        = "Public"
    AZ          = each.value.az
  }
}

resource "aws_subnet" "private" {
  for_each = { for idx, subnet in var.private_subnets : idx => subnet }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name        = "${ var.project_name }-${ var.environment }-subnet-private-${ each.key }"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Tier        = "Private"
    AZ          = each.value.az
  }
}