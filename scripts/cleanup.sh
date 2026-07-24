#!/bin/bash

set -e

echo "Deleting application resources..."

kubectl delete -f k8s/dev/hpa.yaml --ignore-not-found
kubectl delete -f k8s/dev/ingress.yaml --ignore-not-found
kubectl delete -f k8s/dev/service.yaml --ignore-not-found
kubectl delete -f k8s/dev/deployment.yaml --ignore-not-found
kubectl delete -f k8s/dev/configmap.yaml --ignore-not-found
kubectl delete -f k8s/dev/secret.yaml --ignore-not-found
kubectl delete -f k8s/dev/namespace.yaml --ignore-not-found

echo "Cleanup completed."
