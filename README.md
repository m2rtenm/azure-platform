# Azure Platform

Terraform-managed Azure platform, built incrementally as a production-style portfolio project.

## Current phase

**Phase 4 — Container Registry** is ready to apply. It adds a low-cost Basic Azure Container Registry (ACR) to store images for the future AKS platform.

Completed phases:

1. **Bootstrap** — remote Terraform state in Azure Blob Storage.
2. **Repository foundation** — reusable modules, isolated environments, and Azure AD-backed remote state configuration.
3. **Networking** — applied: North Europe VNet, dedicated subnets, NSGs, and route table.
4. **Container Registry** — implemented and validated; awaiting `terraform apply`.

## Repository layout

```text
azure-platform/
├── bootstrap/       # One-time remote Terraform state foundation
├── environments/
│   ├── dev/          # Deployable development environment root
│   └── prod/         # Reserved for a future subscription/environment
├── modules/
│   └── network/      # VNet, subnets, NSGs, and route table
│   └── acr/          # Azure Container Registry
├── docs/             # Platform documentation
└── .github/          # CI/CD workflows added in a later phase
```

Do not commit generated `*.tfvars` files or Terraform state. The repository `.gitignore` protects both by default.

## Next step

Review and apply the Phase 4 plan from `environments/dev`:

```bash
terraform apply acr.tfplan
```

The Basic ACR tier has a small recurring charge. See [`docs/container-registry.md`](docs/container-registry.md) for its security, cost, and upgrade path.
