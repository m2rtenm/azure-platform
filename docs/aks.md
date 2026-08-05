# Azure Kubernetes Service

Phase 5 defines an AKS cluster in North Europe using the Phase 3 AKS subnet and Phase 4 ACR.

## Design

- Azure CNI Overlay with Azure network policy.
- System-assigned? No: a user-assigned managed identity is granted the minimum network and registry roles before cluster creation.
- Azure RBAC, OIDC issuer, workload identity, and Azure Policy are enabled.
- A system node pool stays at one node; an application user pool can scale to zero.

## Cost safety

Do not apply Phase 5 until you accept the ongoing cost of at least one system-node VM and the associated AKS networking resources. The user node pool has a minimum of zero, but a functional cluster cannot scale the system pool to zero.

## Deployment

When ready to accept those costs:

```bash
cd environments/dev
terraform plan -out aks.tfplan
terraform apply aks.tfplan
```

After Azure RBAC permissions are assigned, fetch credentials with `az aks get-credentials` and confirm `kubectl get nodes`.
