module "VPC" {
  source          = "./resources/vpc"
}

module "security_group" {
  source          = "./resources/securityGroup"
  vpc_id_sg       = module.VPC.vpc_id
}

module "database_vm" {
  source                = "./resources/databaseServer"
  ami_id                = var.ami_id
  key_name              = var.key_name 
  subnet1               = module.VPC.private_subnet_1
  subnet2               = module.VPC.private_subnet_2
  security_groups       = [ module.security_group.database_sg ]
  password              = var.password
  root_password         = var.root_password
}

module "LoadBalancer" {
  source          = "./resources/loadBalancer/"
  vpc_id          = module.VPC.vpc_id
  security_group  = [ module.security_group.loadbalancer_sg ]
  load_balancer_subnets      = [module.VPC.public_subnet_1 , module.VPC.public_subnet_2] 
}

module "AutoScaling_Primary" {
  source          = "./resources/autoScaling"
  ami_id          = var.ami_id
  key_name        = var.key_name
  subnets     = [module.VPC.private_subnet_1, module.VPC.private_subnet_2]
  vpc_id          = module.VPC.vpc_id
  security_group  = [ module.security_group.asg_sg ]
  target_group          = [ module.LoadBalancer.target_arn ]
  lburl             = module.LoadBalancer.dns_loadb
  database_address           = module.database_vm.database_ip
  password              = var.password
  root_password         = var.root_password
}