#!/bin/bash

set -e

kubectl rollout undo deployment/django-notes \
-n django-notes

kubectl rollout status deployment/django-notes \
-n django-notes
