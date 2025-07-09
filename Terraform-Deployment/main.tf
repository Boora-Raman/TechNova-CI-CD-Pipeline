 provider "aws" {
  region = "us-east-2"
}

module "Vpc-ubnets" {
  source = "./VPC & SG"   
}     
 
module "Iam_roles" { 
  source = "./IAM & Roles" 
 
}

module "alb" {
  source            = "./ALB"
  vpc_id            = module.Vpc-ubnets.vpc_id
  subnet_ids        = module.Vpc-ubnets.subnet_ids
  security_group_id = toset([module.Vpc-ubnets.allow_tls_sg_id])
}



module "ecs" {
  source            = "./ECS-Cluster"
  execution_role_arn = module.Iam_roles.iam-role
  target_group_arn  = module.alb.blue-target_group_arn
  subnet_ids        = module.Vpc-ubnets.subnet_ids
  security_group_id = toset([module.Vpc-ubnets.allow_tls_sg_id])
  vpc_id            = module.Vpc-ubnets.vpc_id
  depends_on = [module.alb]
}



module "codedeploy" {
  source =  "./codedeploy"
  blue-target_group_arn = module.alb.blue-target_group_arn
  green-target_group_arn = module.alb.green-target_group_arn
  cluster-name = module.ecs.cluster-name
  service-name =module.ecs.service-name
  listener-arns = module.alb.listener-arns
  green-tg-name = module.alb.green-tg-name
  blue-tg-name = module.alb.blue-tg-name

  codedeploy_role_arn = module.Iam_roles.codedeploy_role_arn

}
   
