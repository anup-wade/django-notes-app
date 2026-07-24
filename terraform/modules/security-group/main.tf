#########################################
# ALB Security Group
#########################################

resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-alb-sg"
  })
}

#########################################
# EKS Cluster Security Group
#########################################

resource "aws_security_group" "eks_cluster" {
  name        = "${var.project_name}-${var.environment}-eks-cluster-sg"
  description = "EKS Cluster Security Group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-eks-cluster-sg"
  })
}

#########################################
# Worker Node Security Group
#########################################

resource "aws_security_group" "worker_nodes" {
  name        = "${var.project_name}-${var.environment}-worker-sg"
  description = "Worker Nodes Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description = "Node to Node"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description     = "Control Plane"
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_cluster.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-worker-sg"
  })
}

#########################################
# Cluster -> Worker
#########################################

resource "aws_security_group_rule" "cluster_to_worker" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker_nodes.id
  source_security_group_id = aws_security_group.eks_cluster.id
}

