module "vpc" {
  source                 = "./modules/vpc"
  project_name           = var.project_name
  my_vpc                 = var.my_vpc
  my_vpc_cidr            = var.my_vpc_cidr
  my_public_subnet       = var.my_public_subnet
  my_public_subnet_cidr  = var.my_public_subnet_cidr
  my_private_subnet      = var.my_private_subnet
  my_private_subnet_cidr = var.my_private_subnet_cidr
  my_db_subnet           = var.my_db_subnet
  my_db_cidr             = var.my_db_cidr
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id

}

module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.vpc.vpc_id
  public_sg_id      = module.sg.public_sg_id
  private_sg_id     = module.sg.private_sg_id
  db_sg_id          = module.sg.db_sg_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  db_subnet_id      = module.vpc.db_subnet_id

}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_sg_id      = module.sg.public_sg_id
  public_subnet_id  = module.vpc.public_subnet_id
  web_instances_id  = module.ec2.web_instances_id
  app_instances_id  = module.ec2.app_instances_id
  private_sg_id     = module.sg.private_sg_id
  private_subnet_id = module.vpc.private_subnet_id

}
