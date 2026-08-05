# Development environment

This is the Terraform root for the development platform. It uses the shared Azure Blob backend created by `bootstrap/`; it does not create Azure resources until a module is composed here.

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

The expected Phase 2 plan makes no Azure changes. Phase 3 will compose the network module here.
