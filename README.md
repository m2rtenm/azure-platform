# Azure Platform

Terraform-managed Azure platform, built incrementally as a production-style portfolio project.

## Current phase

Phase 1 is complete in [`bootstrap/`](bootstrap/README.md): it provisions the Azure Storage backend that will hold Terraform state for the later platform stacks.

## Repository layout

```text
azure-platform/
├── bootstrap/       # One-time remote Terraform state foundation
└── docs/            # Platform documentation as later phases are added
```

Do not commit generated `*.tfvars` files or Terraform state. The repository `.gitignore` protects both by default.
