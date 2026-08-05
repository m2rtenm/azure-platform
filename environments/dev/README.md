# Development environment

This is the Terraform root for the development platform. It uses the shared Azure Blob backend created by `bootstrap/` and composes networking, ACR, AKS, PostgreSQL, and the Log Analytics workspace required by AKS Container Insights.

## Backend setup

```bash
cd environments/dev
cp backend.hcl.example backend.hcl
```

Set `storage_account_name` using:

```bash
terraform -chdir=../../bootstrap output -raw storage_account_name
```

Then initialise and verify remote state access:

```bash
terraform init -backend-config=backend.hcl
terraform fmt -check
terraform validate
terraform plan
```

## AKS prerequisites

AKS Azure RBAC automatically reads the tenant ID from the authenticated Azure CLI session. To override it explicitly, create an ignored local variables file:

```hcl
# terraform.tfvars
tenant_id = "<your-microsoft-entra-tenant-id>"
```

Retrieve it with:

```bash
az account show --query tenantId --output tsv
```

The current configuration includes ACR, AKS, and private PostgreSQL. It generates a PostgreSQL administrator password and stores it in encrypted remote Terraform state, so restrict backend access. Review the plan carefully because these services incur Azure charges.
