module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = var.vpc_cidr

  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr

  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2

  common_tags = var.common_tags
}

module "security_group" {
  source = "../../modules/security-group"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  common_tags = var.common_tags
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment

  common_tags = var.common_tags
}

module "eks" {
  source = "../../modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_role_arn = module.iam.cluster_role_arn
  worker_role_arn  = module.iam.worker_role_arn

  private_subnet_ids = [
    module.vpc.private_subnet_1_id,
    module.vpc.private_subnet_2_id
  ]

  cluster_security_group_id = module.security_group.eks_cluster_security_group_id

  common_tags = var.common_tags
}

module "ecr" {
  source = "../../modules/ecr"

  project_name = var.project_name
  environment  = var.environment

  common_tags = var.common_tags
}

