#!/bin/bash

set -e

IMAGE=$1

if [ -z "$IMAGE" ]; then
  echo "Usage: ./update-image.sh <image>"
  exit 1
fi

kubectl set image deployment/django-notes \
django-notes=$IMAGE \
-n django-notes

kubectl rollout status deployment/django-notes \
-n django-notes
