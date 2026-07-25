A complete DevOps project from scratch:

GitHub
   │
   ▼
Jenkins (EC2)
   │
   ├── Build Backend Docker Image
   ├── Build Frontend Docker Image
   ├── Push Images to Amazon ECR
   └── Deploy to Amazon EKS
                    │
                    ▼
              Django Notes App
                    │
         ┌──────────┴──────────┐
         ▼                     ▼
     Django API          React Frontend
                    │
                    ▼
          AWS Load Balancer (ALB)
Project Phases
Phase 1 – AWS Infrastructure (Terraform)

We'll create everything using Terraform.

terraform/
│
├── modules/
│   ├── vpc/
│   ├── iam/
│   ├── ecr/
│   ├── eks/
│   ├── alb/
│   └── security-groups/
│
├── dev/
│   ├── backend.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   └── outputs.tf
│
└── versions.tf

Terraform will create:

VPC
Public & Private Subnets
Internet Gateway
NAT Gateway
Route Tables
Security Groups
IAM Roles
Amazon ECR (Backend)
Amazon ECR (Frontend)
Amazon EKS Cluster
Managed Node Group
OIDC Provider
AWS Load Balancer Controller IAM Policy
Phase 2 – Jenkins Server

Terraform can also create a Jenkins EC2 instance.

We'll install:

Jenkins
Docker
AWS CLI
kubectl
eksctl
Git
Java
Docker Buildx
Phase 3 – Django Notes Application

Project structure:

django-notes-app/

backend/

frontend/

k8s/

terraform/

Jenkinsfile

README.md
Phase 4 – Docker

Backend

Dockerfile

Frontend

Dockerfile

Custom nginx

nginx/default.conf
Phase 5 – Amazon ECR

Terraform creates:

notesapp-backend

notesapp-frontend

Images pushed automatically from Jenkins.

Phase 6 – Amazon EKS

Terraform creates:

EKS Cluster
Node Group
IAM
Security Groups
Phase 7 – Kubernetes
k8s/

namespace.yaml

backend-deployment.yaml

backend-service.yaml

frontend-deployment.yaml

frontend-service.yaml

ingress.yaml

hpa.yaml

configmap.yaml

secret.yaml
Phase 8 – Jenkins Pipeline

Pipeline stages:

Checkout

Build Backend

Build Frontend

Scan Images (Trivy)

Push Backend

Push Frontend

Deploy Backend

Deploy Frontend

Verify Deployment

Cleanup

The pipeline will:

Clone from GitHub
Build Docker images
Push to ECR
Update Kubernetes deployments
Wait for rollout
Verify pods are healthy
Fail automatically if deployment fails
Phase 9 – Monitoring
Prometheus
Grafana
Metrics Server
Phase 10 – Ingress

We'll use the AWS Load Balancer Controller.

Result:

Internet
      │
      ▼
Application Load Balancer
      │
 ┌────┴────┐
 ▼         ▼
Frontend   Backend
Phase 11 – Security
IAM Roles for Service Accounts (IRSA)
Kubernetes Secrets
Least-privilege IAM policies
No AWS credentials stored in Jenkinsfile (use the EC2 IAM role)
Phase 12 – Documentation

We'll prepare:

Architecture Diagram
Terraform Diagram
Jenkins Pipeline Diagram
Kubernetes Diagram
Deployment Guide
Troubleshooting Guide
Interview Questions & Answers
Final Repository Structure
django-notes-app/
│
├── backend/
├── frontend/
├── nginx/
├── k8s/
│
├── terraform/
│   ├── modules/
│   └── dev/
│
├── Jenkinsfile
├── README.md
└── deployment-guide.md
What We'll Achieve

At the end, you'll have a fully automated deployment where:

Developer
     │
git push
     │
     ▼
GitHub
     │
Webhook
     ▼
Jenkins
     │
Build Docker Images
     │
Push to Amazon ECR
     │
Deploy to Amazon EKS
     │
Wait for Rollout
     │
Application Available via AWS Load Balancer
