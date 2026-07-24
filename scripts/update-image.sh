#!/bin/bash

set -euo pipefail

IMAGE="$1"

if [ $# -ne 1 ]; then
    echo "Usage: $0 <image>"
    exit 1
fi

echo "Updating deployment image to:"
echo "$IMAGE"

kubectl set image deployment/django-notes \
django-notes="$IMAGE" \
-n django-notes

kubectl rollout status deployment/django-notes \
-n django-notes \
--timeout=5m

echo "Deployment updated successfully."