output "id" {
  description = "PostgreSQL Flexible Server resource ID."
  value       = azurerm_postgresql_flexible_server.this.id
}

output "name" {
  description = "PostgreSQL Flexible Server name."
  value       = azurerm_postgresql_flexible_server.this.name
}

output "fqdn" {
  description = "Private PostgreSQL server FQDN."
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "database_name" {
  description = "Initial application database name."
  value       = azurerm_postgresql_flexible_server_database.this.name
}

output "administrator_login" {
  description = "PostgreSQL administrator login."
  value       = azurerm_postgresql_flexible_server.this.administrator_login
}

output "administrator_password" {
  description = "Generated PostgreSQL administrator password. Store this in Key Vault in Phase 7."
  value       = random_password.administrator.result
  sensitive   = true
}
