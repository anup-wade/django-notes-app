variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM Role ARN for EKS Cluster"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "cluster_security_group_id" {
  description = "EKS Cluster Security Group ID"
  type        = string
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}

variable "worker_role_arn" {
  description = "IAM Role ARN for Worker Nodes"
  type        = string
}

