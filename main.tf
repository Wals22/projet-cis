module "key_pair" {
  source = "./modules/key_pair"
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
  public_rt_id = module.vpc.public_rt_id
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "load_balancer" {
  source = "./modules/load_balancer"
  vpc_id = module.vpc.vpc_id
  security_group_id = module.security_groups.security_group_id
  public_subnet_ids = module.subnets.public_subnet_ids
}

module "waf" {
  source = "./modules/waf"
  lb_arn = module.load_balancer.lb_arn
}

module "launch_template" {
  source = "./modules/launch_template"
  aws_ami_id = var.aws_ami_id
  security_group_id = module.security_groups.security_group_id
}

module "asg" {
  source = "./modules/asg"
  public_subnet_ids = module.subnets.public_subnet_ids
  launch_template_id = module.launch_template.launch_template_id
  tg_arn = module.load_balancer.tg_arn
}
