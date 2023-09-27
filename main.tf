module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr_block  = var.vpc_cidr_block
  cidr_public_sn  = var.cidr_public_sn
  cidr_private_sn = var.cidr_private_sn
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id

  
}

module "instance-ec2" {
  source    = "./modules/ec2"
  public_subnet_id     = module.vpc.subnet_id
  security_grp = module.sg.sg_id

}
