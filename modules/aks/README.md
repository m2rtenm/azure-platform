# AKS module

Creates a production-oriented AKS foundation with Azure CNI Overlay, Azure RBAC, workload identity, OIDC issuer, Azure Policy, automatic patch upgrades, and cluster autoscaling.

## Node pools and cost

- The **system** pool has a minimum of one `Standard_B2s` VM. It is required for core Kubernetes services and incurs VM charges continuously.
- The **user** pool can autoscale to zero, so application capacity costs nothing while it has no nodes.
- The standard Azure Load Balancer created for AKS can also incur charges once it handles traffic.

This module intentionally does not create Log Analytics monitoring until the monitoring phase.

## Identity

The module creates a user-assigned managed identity and grants it:

- `Network Contributor` on the AKS subnet, before cluster creation;
- `AcrPull` on the project ACR.

To access the cluster locally after deployment, use Azure RBAC then run:

```bash
az aks get-credentials --resource-group "rg-azplat-dev-neu" --name "aks-azplat-dev" --overwrite-existing
kubectl get nodes
```
