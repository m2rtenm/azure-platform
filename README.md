# Azure Platform

Terraform-managed Azure platform, built incrementally as a production-style portfolio project.

## Current phase

**Phase 3 — Networking** is ready to apply. It defines the North Europe development network: a platform resource group, VNet, dedicated AKS, PostgreSQL, Application Gateway, and private-endpoint subnets, network security groups, and a route table.

Completed phases:

1. **Bootstrap** — remote Terraform state in Azure Blob Storage.
2. **Repository foundation** — reusable modules, isolated environments, and Azure AD-backed remote state configuration.
3. **Networking** — implemented and validated; awaiting `terraform apply`.

## Repository layout

```text
azure-platform/
├── bootstrap/       # One-time remote Terraform state foundation
├── environments/
│   ├── dev/          # Deployable development environment root
│   └── prod/         # Reserved for a future subscription/environment
├── modules/
│   └── network/      # VNet, subnets, NSGs, and route table
├── docs/             # Platform documentation
└── .github/          # CI/CD workflows added in a later phase
```

Do not commit generated `*.tfvars` files or Terraform state. The repository `.gitignore` protects both by default.

## Next step

Review and apply the Phase 3 plan from `environments/dev`:

```bash
terraform apply network.tfplan
```

The planned network foundation has no recurring resource charge on its own. See [`docs/networking.md`](docs/networking.md) for the topology and constraints.
