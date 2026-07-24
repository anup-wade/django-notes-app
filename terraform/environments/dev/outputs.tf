output "region" {
  value = var.aws_region
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1_id" {
  value = module.vpc.public_subnet_1_id
}

output "public_subnet_2_id" {
  value = module.vpc.public_subnet_2_id
}

output "private_subnet_1_id" {
  value = module.vpc.private_subnet_1_id
}

output "private_subnet_2_id" {
  value = module.vpc.private_subnet_2_id
}

output "alb_security_group_id" {
  value = module.security_group.alb_security_group_id
}

output "eks_cluster_security_group_id" {
  value = module.security_group.eks_cluster_security_group_id
}

output "worker_security_group_id" {
  value = module.security_group.worker_security_group_id
}


output "cluster_role_arn" {
  value = module.iam.cluster_role_arn
}

output "worker_role_arn" {
  value = module.iam.worker_role_arn
}


output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}


output "backend_repository_url" {
  value = module.ecr.backend_repository_url
}

output "frontend_repository_url" {
  value = module.ecr.frontend_repository_url
}

output "backend_repository_name" {
  value = module.ecr.backend_repository_name
}

output "frontend_repository_name" {
  value = module.ecr.frontend_repository_name
}

