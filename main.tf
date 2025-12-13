module "iam" {
  source              = "./modules/iam"
  environment         = var.environment
  aws_region          = var.aws_region
  project_name        = var.project_name
  rds_dbi_resource_id = module.database.rds_dbi_resource_id
  db_user             = var.db_user
}

module "network" {
  source          = "./modules/network"
  environment     = var.environment
  aws_region      = var.aws_region
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "compute" {
  source             = "./modules/compute"
  environment        = var.environment
  project_name       = var.project_name
  instance_type      = var.instance_type
  vpc_id             = module.network.vpc_id
  subnet_id          = module.network.public_subnet_ids[0]
  ec2_keypair_name   = var.ec2_keypair_name
  ec2_ssh_public_key = var.ec2_ssh_public_key
}

module "database" {
  source                 = "./modules/database"
  environment            = var.environment
  project_name           = var.project_name
  db_name                = var.db_name
  db_user                = var.db_admin_user
  db_password            = var.db_admin_password
  vpc_id                 = module.network.vpc_id
  private_db_subnet_ids  = module.network.private_subnet_ids
  vpc_security_group_ids = module.compute.vpc_security_group_ids
  ec2_security_group_id  = module.compute.ec2_security_group_id
}

module "storage" {
  source                 = "./modules/storage"
  environment            = var.environment
  project_name           = var.project_name
}