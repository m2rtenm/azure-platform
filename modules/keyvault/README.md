# Key Vault module

Creates a private, RBAC-authorized Azure Key Vault for platform secrets.

- Public network access is disabled.
- A private endpoint and `privatelink.vaultcore.azure.net` private DNS zone make the vault reachable only from the platform VNet.
- Soft delete is configured and purge protection is permanently enabled.
- Terraform's authenticated principal receives `Key Vault Administrator` to manage declared secrets.
- A user-assigned workload identity receives only `Key Vault Secrets User`, ready for AKS workload identity federation in the Kubernetes platform phase.

## PostgreSQL secrets

The module stores the generated PostgreSQL administrator password and a TLS-required connection string. Secret values remain in encrypted Terraform state because Terraform must create them; restrict remote-state access. Applications should read the secrets from Key Vault through workload identity rather than from Terraform outputs.
