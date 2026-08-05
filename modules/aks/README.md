# AKS module

Creates a production-oriented Azure Kubernetes Service (AKS) baseline:

- User-assigned identities for the control plane and kubelets.
- Azure RBAC, Azure Policy, OIDC issuer, workload identity, and disabled local accounts.
- Azure CNI Overlay with Azure network policy.
- Dedicated autoscaling system and user node pools.
- Container Insights with managed-identity authentication.
- `Network Contributor` on the AKS subnet and `AcrPull` only for the kubelet identity.
- Configurable automatic upgrade channel and node image updates.

## Development capacity and cost

The development defaults keep one low-cost system node available and permit the user workload pool to scale to zero. AKS, virtual machines, the standard load balancer, ACR, and Log Analytics can all incur Azure charges.

## Networking requirements

The AKS node subnet must not overlap with the pod or service CIDRs. The development defaults use:

| Range | Purpose |
| --- | --- |
| `10.0.1.0/24` | AKS nodes |
| `10.244.0.0/16` | Azure CNI Overlay pods |
| `10.2.0.0/24` | Kubernetes services |
