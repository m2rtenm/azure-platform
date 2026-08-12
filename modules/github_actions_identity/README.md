# GitHub Actions identity

This module creates a user-assigned managed identity and a GitHub Actions OIDC
federated credential. The credential trusts one exact GitHub Actions subject;
it never creates or stores a client secret.

The identity receives Contributor and User Access Administrator only at the
platform resource-group scope so Terraform can manage resources and their role
assignments. It receives `AcrPush` only on the platform registry. Argo CD
deploys application changes, so CI has no Kubernetes cluster-admin role. Azure
Blob state access is intentionally separate because the backend can be in a
different resource group.
