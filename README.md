# Django Notes App - End-to-End DevOps on AWS EKS

## Project Overview

## Architecture Diagram

## Technology Stack

## Features

## Prerequisites

## Repository Structure

## Phase 1 - Clone Repository

## Phase 2 - AWS Infrastructure with Terraform

## Phase 3 - Configure AWS CLI

## Phase 4 - Deploy Infrastructure

## Phase 5 - Create EKS Cluster

## Phase 6 - Configure kubectl

## Phase 7 - Install Jenkins

## Phase 8 - Configure Jenkins

## Phase 9 - Configure IAM Role

## Phase 10 - Create ECR Repositories

## Phase 11 - Docker Images

## Phase 12 - Kubernetes Deployment

## Phase 13 - Jenkins Pipeline

## Phase 14 - Verify Deployment

## Phase 15 - Troubleshooting

## Destroy Infrastructure

## Screenshots

## Future Improvements

## Author




Project Overview

Explainations:

Why this project exists
What it does
Architecture
CI/CD Flow
Architecture

Include diagrams.

Developer

↓

GitHub

↓

Jenkins

↓

Docker

↓

Amazon ECR

↓

Amazon EKS

↓

AWS Load Balancer

↓

Users

Later we'll create professional diagrams.

Repository Structure
django-notes-app/

backend/

frontend/

nginx/

terraform/

modules/

vpc/

ecr/

eks/

iam/

jenkins/

k8s/

namespace.yaml

backend-deployment.yaml

frontend-deployment.yaml

service.yaml

ingress.yaml

Jenkinsfile

README.md
Terraform

Explain every module.

Example

terraform/

modules/

vpc/

Creates VPC

Subnets

Route Tables

NAT Gateway

Internet Gateway

eks/

Creates

EKS Cluster

Managed Node Groups

IAM

OIDC

ecr/

Creates

Backend Repository

Frontend Repository

iam/

Creates

Node IAM Role

Cluster IAM Role

IRSA
Jenkins Installation

Everything

Install Java

Install Jenkins

Install Docker

Install AWS CLI

Install kubectl

Install eksctl

Configure IAM Role

Restart Jenkins

Install Plugins

Docker Plugin

Pipeline Plugin

Git Plugin

Blue Ocean

Include every command.

Jenkins Configuration
Create Pipeline

Configure SCM

GitHub Repository

Webhook

Credentials

Environment Variables

Pipeline Script
Docker

Explain

Backend Dockerfile

Frontend Dockerfile

Multi-stage build

Nginx Reverse Proxy

ECR
aws ecr create-repository

docker tag

docker push
Kubernetes

Explain every manifest.

Namespace

Deployment

Service

Ingress

ConfigMap

Secret

HPA

Explain why each exists.

CI/CD Pipeline

Every stage.

Checkout

Build Backend

Build Frontend

Trivy Scan

Push Backend

Push Frontend

Deploy Backend

Deploy Frontend

Verify Deployment

Cleanup

Include screenshots.

Validation

Commands

kubectl get pods

kubectl get svc

kubectl get ingress

kubectl describe pod

kubectl logs
Troubleshooting

Very important.

Example

ImagePullBackOff

CrashLoopBackOff

502 Bad Gateway

Readiness Probe Failed

Liveness Probe Failed

Database Connection Failed

AWS Authentication Failed

Docker Build Failed

Terraform Apply Failed

Jenkins Workspace Issues

Nginx Reverse Proxy Issues

Explain root cause and resolution for each.

Destroy Infrastructure
terraform destroy

Delete ECR Images

Delete Jenkins

Delete EBS

Delete ALB
Cost Estimation

Include estimated AWS monthly costs.

Service	Estimated Monthly Cost
EKS	$70
EC2 (Jenkins)	$15
NAT Gateway	$35
ECR	$2
ALB	$20
CloudWatch	$5
Future Improvements
ArgoCD

Helm

Terraform Cloud

GitHub Actions

Prometheus

Grafana

SonarQube

OPA

Karpenter
