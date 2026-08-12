# Key Vault

Phase 7 provisions a private, RBAC-authorized Key Vault.

## Security model

- Public network access is disabled; the vault is reachable through a private endpoint and `privatelink.vaultcore.azure.net` private DNS.
- Soft delete is configured for 90 days and purge protection is enabled.
- Terraform's authenticated principal has `Key Vault Administrator` only to manage declared secrets.
- The platform workload identity has `Key Vault Secrets User`, allowing it to read secrets but not alter them.

## Stored secrets

- `postgresql-administrator-password`
- `postgresql-connection-string`

Terraform must retain the generated database password in encrypted remote state. Restrict state access and consume the application connection string through workload identity or the CSI driver.
