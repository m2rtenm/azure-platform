# Azure Platform

Terraform-managed Azure platform, built incrementally as a production-style portfolio project.

## Current phase

**Phase 6 — PostgreSQL** is implemented and ready to apply. It adds a private Azure Database for PostgreSQL Flexible Server for platform workloads.

Completed phases:

1. **Bootstrap** — remote Terraform state in Azure Blob Storage.
2. **Repository foundation** — reusable modules, isolated environments, and Azure AD-backed remote state configuration.
3. **Networking** — applied: North Europe VNet, dedicated subnets, NSGs, and route table.
4. **Container Registry** — Basic SKU image registry, with Entra ID/RBAC authentication and admin access disabled.
5. **AKS** — system and user pools, autoscaling, Azure CNI Overlay, Azure RBAC/Policy, OIDC/workload identity, Container Insights, and least-privilege ACR pulls.
6. **PostgreSQL** — private Flexible Server, delegated subnet, private DNS, generated administrator credential, automated backups, and an initial application database.

## Repository layout

```text
azure-platform/
├── bootstrap/       # One-time remote Terraform state foundation
├── environments/
│   ├── dev/          # Deployable development environment root
│   └── prod/         # Reserved for a future subscription/environment
├── modules/
│   ├── network/      # VNet, subnets, NSGs, and route table
│   ├── acr/          # Azure Container Registry
│   └── aks/          # AKS cluster, node pools, RBAC, and identity
│   └── postgresql/   # Private PostgreSQL Flexible Server and DNS
├── docs/             # Platform documentation
└── .github/          # CI/CD workflows added in a later phase
```

Do not commit generated `*.tfvars` files or Terraform state. The repository `.gitignore` protects both by default.

## Next step

The Phase 6 apply creates ACR, AKS, the Log Analytics workspace, and private PostgreSQL resources. These services incur Azure charges.

AKS derives the Microsoft Entra tenant from the active Azure CLI session. To override it, set `tenant_id` in an ignored local `terraform.tfvars`:

```bash
tenant_id = "<your-microsoft-entra-tenant-id>"
```

Then review and apply the platform plan:

```bash
cd environments/dev
terraform init -backend-config=backend.hcl
terraform plan -out platform.tfplan
terraform apply platform.tfplan
```

After deployment, configure `kubectl`:

```bash
az aks get-credentials --resource-group rg-azplat-dev-neu --name aks-azplat-dev
kubectl get nodes
```

See [`modules/aks/README.md`](modules/aks/README.md) for the module architecture and network requirements.

See [`modules/postgresql/README.md`](modules/postgresql/README.md) for the private networking and state-security considerations.
