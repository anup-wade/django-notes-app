#!/bin/bash

echo "===== Nodes ====="
kubectl get nodes

echo ""

echo "===== Pods ====="
kubectl get pods -n django-notes

echo ""

echo "===== Services ====="
kubectl get svc -n django-notes

echo ""

echo "===== Ingress ====="
kubectl get ingress -n django-notes

echo ""

echo "===== HPA ====="
kubectl get hpa -n django-notes
