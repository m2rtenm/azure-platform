# Terraform layout and state

Terraform is split into independently deployable environment roots under `environments/`, with reusable implementation in `modules/`.

An environment root owns provider configuration, the remote-state backend, environment-specific variables, and module composition. A module must not define a provider or backend.

The bootstrap stack initially uses local state because it creates the storage backend. Every later environment root uses the Azure Blob backend created by bootstrap.

Use a different state key for each independent deployment. The initial development root uses `dev/platform.tfstate`. If the platform later grows into separately deployed layers, use keys such as `dev/network.tfstate` and `dev/aks.tfstate`.

State storage uses Microsoft Entra ID authentication (`use_azuread_auth = true`). The identity running Terraform needs **Storage Blob Data Contributor** on the bootstrap storage account.

```bash
cd environments/dev
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
terraform fmt -check
terraform validate
terraform plan
```
