output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "worker_role_arn" {
  value = aws_iam_role.worker_nodes.arn
}
