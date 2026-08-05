# Container Registry

Phase 4 adds Azure Container Registry (ACR) in North Europe. It holds the container images that future AKS workloads will pull.

## Security model

- Microsoft Entra ID and Azure RBAC authenticate image pushes and pulls.
- The legacy ACR admin user and anonymous pull access are disabled.
- The Basic SKU initially keeps public network access enabled for local development and future GitHub-hosted CI runners. Authentication remains required.

## Cost and upgrade path

The development default is the Basic SKU. It includes 10 GiB of storage and is intended for development and learning workloads. Premium is required only when private endpoints or geo-replication are needed. Choose Premium later, when the related network controls are implemented, rather than paying for it now.

## Deploy

```bash
cd environments/dev
terraform plan -out acr.tfplan
terraform apply acr.tfplan
```
