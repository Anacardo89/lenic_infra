resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.project_name}-${var.env}-vpc"
    Project     = var.project_name
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}

resource "aws_subnet" "public_web" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/25"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-${var.env}-public-web"
    Project     = var.project_name
    Environment = var.env
    ManagedBy   = "Terraform"
    Tier        = "Public"
    AZ          = "${var.aws_region}a"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-${var.env}-igw"
    Project     = var.project_name
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}
