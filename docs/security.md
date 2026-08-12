# Security controls

## Azure and identity

- AKS disables local accounts, enables Azure RBAC, Azure Policy, OIDC, workload
  identity, automatic patch upgrades, and a separate kubelet identity.
- ACR disables admin, anonymous, and data-endpoint access. AKS pulls through
  its kubelet `AcrPull` role; CI receives only `AcrPush`.
- PostgreSQL and Key Vault use private endpoints or private networking. Key
  Vault uses RBAC, purge protection, and a workload identity with
  `Key Vault Secrets User`.
- GitHub Actions uses a subject-bound OIDC federation instead of a credential.

## Kubernetes workloads

The `sample-app` namespace is Pod Security Admission `restricted`. Both
workloads run as non-root, use RuntimeDefault seccomp, drop all Linux
capabilities, disallow privilege escalation, use read-only root filesystems,
and disable service-account token mounting. Resource requests/limits, HPAs,
PDBs, and default-deny NetworkPolicies are included. The backend can egress
only to cluster DNS and the private PostgreSQL subnet; the frontend can reach
only the backend.

## Operations

Do not weaken these controls to diagnose an issue. Follow
[runbooks](runbooks.md), rotate a secret at its source in Key Vault, and verify
the ExternalSecret condition before changing a workload. Review Azure role
assignments and GitHub Environment protection rules quarterly.
