module "network" {
  source          = "./modules/network"
  environment     = var.environment
  aws_region      = var.aws_region
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "iam" {
  source       = "./modules/iam"
  environment  = var.environment
  project_name = var.project_name
}