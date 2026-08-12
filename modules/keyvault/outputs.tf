output "id" {
  description = "Key Vault resource ID."
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "Key Vault name."
  value       = azurerm_key_vault.this.name
}

output "uri" {
  description = "Key Vault URI."
  value       = azurerm_key_vault.this.vault_uri
}

output "workload_identity_client_id" {
  description = "Client ID of the workload managed identity with Key Vault Secrets User."
  value       = azurerm_user_assigned_identity.workload.client_id
}

output "workload_identity_principal_id" {
  description = "Principal ID of the workload managed identity with Key Vault Secrets User."
  value       = azurerm_user_assigned_identity.workload.principal_id
}

output "postgresql_administrator_password_secret_id" {
  description = "Resource ID of the PostgreSQL administrator-password secret."
  value       = azurerm_key_vault_secret.postgresql_administrator_password.id
}

output "postgresql_connection_string_secret_id" {
  description = "Resource ID of the PostgreSQL connection-string secret."
  value       = azurerm_key_vault_secret.postgresql_connection_string.id
}
