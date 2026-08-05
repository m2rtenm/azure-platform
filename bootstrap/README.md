# Terraform remote-state bootstrap

This is the one stack that initially uses local state. It creates a resource group, a private Azure Blob container, and a hardened StorageV2 account for the remote state of all later Terraform stacks.

The state account uses HTTPS and TLS 1.2+, disables public blob access, and enables blob versioning. AzureRM needs shared-key access while it creates the initial container, so keys remain enabled for this bootstrap account; the Terraform backend below uses Azure AD instead. Public network access remains enabled only so your local workstation and GitHub Actions can reach the backend; later phases can restrict it with private networking or a firewall.

## Prerequisites

- Terraform `>= 1.6`
- Azure CLI authenticated to the intended subscription
- Azure permissions to create a resource group and storage account (for example, Contributor at subscription scope)

First select the subscription explicitly:

```bash
az login
az account set --subscription "<subscription-id>"
az account show --output table
```

## Deploy the bootstrap stack

```bash
cd bootstrap
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars if you want different names, region, or tags.
terraform init
terraform fmt -check
terraform validate
terraform plan -out bootstrap.tfplan
terraform apply bootstrap.tfplan
```

Record the outputs after apply:

```bash
terraform output backend_config
```

## Allow state access with Azure RBAC

Configure the Terraform backend to use Azure AD authentication, rather than the storage-account keys. Assign the identity that runs Terraform the **Storage Blob Data Contributor** role on the storage account. For a locally signed-in user:

```bash
STORAGE_ACCOUNT_NAME="$(terraform output -raw storage_account_name)"
STORAGE_ACCOUNT_ID="$(az storage account show --name "$STORAGE_ACCOUNT_NAME" --resource-group "$(terraform output -raw resource_group_name)" --query id --output tsv)"
SIGNED_IN_OBJECT_ID="$(az ad signed-in-user show --query id --output tsv)"

az role assignment create \
  --assignee-object-id "$SIGNED_IN_OBJECT_ID" \
  --assignee-principal-type User \
  --role "Storage Blob Data Contributor" \
  --scope "$STORAGE_ACCOUNT_ID"
```

If Azure AD permissions prevent `az ad signed-in-user show`, ask a subscription administrator to make this role assignment for your user or Terraform service principal.

## Configure later Terraform stacks

Later environment stacks should use an `azurerm` backend. Do not add credentials to the backend block or commit backend configuration containing secrets.

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev-neu"
    storage_account_name = "<output storage_account_name>"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
    use_azuread_auth     = true
    use_cli              = true
  }
}
```

Use a distinct `key` per independently deployed stack, such as `dev/network.tfstate` and `dev/aks.tfstate`. When migrating an existing local state into this backend, run `terraform init -migrate-state` from that stack.

## Important operating notes

- Keep `bootstrap/terraform.tfstate` only on your encrypted local machine until you deliberately migrate it; it is excluded from Git.
- Do not run `terraform destroy` for this stack while other Terraform stacks depend on this backend.
- Blob Change Feed is deliberately disabled: it is not useful for Terraform state and avoids its small per-change storage cost.
- The initial `terraform init` must download provider plugins. Commit the generated `.terraform.lock.hcl` after reviewing it; it is intentionally not ignored.
