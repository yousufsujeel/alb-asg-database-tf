# Configure aws provider
provider "aws" {
    region    = var.region
   # profile   = "terraform-user"
}

# Create vpc
module "vpc" {
   source                       = "../modules/vpc"
   region                       =  var.region
   project_name                 =  var.project_name
   env                          =  var.env
   vpc_cidr                     =  var.vpc_cidr
   public_subnet_az1_cidr       =  var.public_subnet_az1_cidr
   public_subnet_az2_cidr       =  var.public_subnet_az2_cidr 
   private_app_subnet_az1_cidr  =  var.private_app_subnet_az1_cidr 
   private_app_subnet_az2_cidr  =  var.private_app_subnet_az2_cidr
   private_data_subnet_az1_cidr =  var.private_data_subnet_az1_cidr
   private_data_subnet_az2_cidr =  var.private_data_subnet_az2_cidr
   common_tags                  =  local.common_tags
}  

# create nat gateways
module  "nat_gateway" {
   source                        = "../modules/nat_gateway"
   public_subnet_az1_id          = module.vpc.public_subnet_az1_id
   internet_gateway              = module.vpc.internet_gateway
   public_subnet_az2_id          = module.vpc.public_subnet_az2_id
   vpc_id                        = module.vpc.vpc_id
   private_app_subnet_az1_id     = module.vpc.private_app_subnet_az1_id
   private_data_subnet_az1_id    = module.vpc.private_data_subnet_az1_id
   private_app_subnet_az2_id     = module.vpc.private_app_subnet_az2_id
   private_data_subnet_az2_id    = module.vpc.private_data_subnet_az2_id
   
}

# create security groups
module "security_groups" {
   source        = "../modules/security_groups"
   project_name  =  var.project_name
   env           =  var.env
   vpc_id        =  module.vpc.vpc_id
   common_tags   =  local.common_tags
}

# create ACM Cert
module "acm"  {
  source                = "../modules/acm"
  domain_name           = var.domain_name
  alternative_name      = var.alternative_name
}


# create Application Load Balancer 
module "alb" {
   source                  = "../modules/alb"
   project_name            = module.vpc.project_name
   env                     = var.env
   alb_security_group_id   = module.security_groups.alb_security_group_id
   public_subnet_az1_id    = module.vpc.public_subnet_az1_id
   public_subnet_az2_id    = module.vpc.public_subnet_az2_id
   vpc_id                  = module.vpc.vpc_id
   certificate_arn         = module.acm.certificate_arn
   common_tags             =  local.common_tags
}

#Create EC2 in ASG
module "ec2_asg" {
  source                    = "../modules/ec2_asg"
  project_name              = var.project_name
  env                       = var.env
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  key_name                  = var.key_name
  vpc_zone_identifier       = [module.vpc.private_app_subnet_az1_id, module.vpc.private_app_subnet_az2_id]
  ec2_security_group_id     = [module.security_groups.ec2_security_group_id]
  target_group_arn          = module.alb.alb_target_group_arn 
  user_data_base64          = base64encode(file("userdata.sh"))
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  high_network_in_threshold = var.high_network_in_threshold 
  low_network_in_threshold  = var.low_network_in_threshold
}


module "mysql_rds" {
    source                     = "../modules/rds"
    project_name               =  var.project_name
    env                        =  var.env
    identifier                 = "mysql-instance"
    username                   = "admin"
    vpc_id                     =  module.vpc.vpc_id
    subnet_ids                 = [module.vpc.private_data_subnet_az1_id, module.vpc.private_data_subnet_az2_id] 
    ingress_security_groups    = [module.security_groups.ec2_security_group_id]
    engine                     = "mysql"
    
} 
