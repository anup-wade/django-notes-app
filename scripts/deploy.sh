#!/bin/bash

set -e

echo "Creating namespace..."
kubectl apply -f k8s/dev/namespace.yaml

echo "Applying ConfigMap..."
kubectl apply -f k8s/dev/configmap.yaml

echo "Applying Secret..."
kubectl apply -f k8s/dev/secret.yaml

echo "Deploying application..."
kubectl apply -f k8s/dev/deployment.yaml

echo "Creating Service..."
kubectl apply -f k8s/dev/service.yaml

echo "Creating Ingress..."
kubectl apply -f k8s/dev/ingress.yaml

echo "Creating HPA..."
kubectl apply -f k8s/dev/hpa.yaml

echo "Waiting for rollout..."
kubectl rollout status deployment/django-notes -n django-notes

echo "Deployment completed successfully."
