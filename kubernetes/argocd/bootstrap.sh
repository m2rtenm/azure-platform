#!/usr/bin/env bash
set -euo pipefail

kubectl apply -f kubernetes/argocd/projects/platform.yaml
kubectl apply -f kubernetes/argocd/applications/root.yaml
