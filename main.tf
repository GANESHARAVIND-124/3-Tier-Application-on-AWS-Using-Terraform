module "networking" {
  source = "./modules/networking"

  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "database" {
  source             = "./modules/database"
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids # ✅ Ensure this exists in networking outputs
  ec2_sg_id          = module.networking.ec2_sg_id          # ✅ Fix: Pass from networking module
  db_password        = var.db_password
}

module "compute" {
  source             = "./modules/compute"
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids

  key_name         = var.key_name
  ami_id           = var.ami_id
  ec2_sg_id        = module.networking.ec2_sg_id
  alb_sg_id        = module.networking.alb_sg_id
  target_group_arn = module.compute.target_group_arn
}