output "client_id" {
  description = "Client ID configured in GitHub Actions as AZURE_CLIENT_ID."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "principal_id" {
  description = "Principal ID assigned platform delivery roles."
  value       = azurerm_user_assigned_identity.this.principal_id
}
