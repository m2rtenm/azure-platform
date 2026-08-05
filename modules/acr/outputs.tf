output "id" {
  description = "Container Registry resource ID."
  value       = azurerm_container_registry.this.id
}

output "login_server" {
  description = "Fully qualified registry login server."
  value       = azurerm_container_registry.this.login_server
}

output "name" {
  description = "Globally unique registry name."
  value       = azurerm_container_registry.this.name
}
