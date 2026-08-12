# Azure Platform

Terraform-managed Azure platform, built incrementally as a production-style portfolio project.

## Current phase

**Phase 9 — Monitoring** is implemented and ready to apply. It centralizes Azure platform logs and metrics in Log Analytics.

Completed phases:

1. **Bootstrap** — remote Terraform state in Azure Blob Storage.
2. **Repository foundation** — reusable modules, isolated environments, and Azure AD-backed remote state configuration.
3. **Networking** — applied: North Europe VNet, dedicated subnets, NSGs, and route table.
4. **Container Registry** — Basic SKU image registry, with Entra ID/RBAC authentication and admin access disabled.
5. **AKS** — system and user pools, autoscaling, Azure CNI Overlay, Azure RBAC/Policy, OIDC/workload identity, Container Insights, and least-privilege ACR pulls.
6. **PostgreSQL** — private Flexible Server, delegated subnet, private DNS, generated administrator credential, automated backups, and an initial application database.
7. **Key Vault** — RBAC authorization, private endpoint and DNS, soft delete, purge protection, PostgreSQL secrets, and a least-privilege workload identity.
8. **Application Gateway** — public static IP, HTTPS listener, WAF v2 OWASP policy, autoscaling, and an AKS ingress-ready backend pool.
9. **Monitoring** — Log Analytics workspace, AKS Container Insights, and diagnostics for AKS, PostgreSQL, Key Vault, Application Gateway, and ACR.

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
│   └── keyvault/     # Private RBAC Key Vault and platform secrets
│   └── application_gateway/ # Public WAF v2 HTTPS ingress
│   └── monitoring/   # Platform diagnostics and Log Analytics
├── docs/             # Platform documentation
└── .github/          # CI/CD workflows added in a later phase
```

Do not commit generated `*.tfvars` files or Terraform state. The repository `.gitignore` protects both by default.

## Next step

The Phase 9 apply creates ACR, AKS, a centralized Log Analytics workspace, private PostgreSQL and Key Vault resources, Application Gateway WAF v2, and platform diagnostic settings. These services incur Azure charges.

AKS derives the Microsoft Entra tenant from the active Azure CLI session. To override it, set `tenant_id` in an ignored local `terraform.tfvars`:

```bash
tenant_id = "<your-microsoft-entra-tenant-id>"
```

Add the HTTPS listener certificate values to the same ignored file:

```hcl
application_gateway_ssl_certificate_data     = "<base64-encoded-pfx>"
application_gateway_ssl_certificate_password = "<pfx-password>"
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

See [`modules/keyvault/README.md`](modules/keyvault/README.md) for Key Vault access and secret-management guidance.

See [`modules/application_gateway/README.md`](modules/application_gateway/README.md) for certificate handling, WAF, and backend-integration guidance.

See [`modules/monitoring/README.md`](modules/monitoring/README.md) for diagnostics coverage, retention, and cost guidance.
