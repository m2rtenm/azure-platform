output "resource_group_name" {
  description = "Resource group containing the platform network."
  value       = azurerm_resource_group.this.name
}

output "vnet_id" {
  description = "Virtual network resource ID."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Virtual network name."
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Subnet IDs keyed by platform role."
  value = {
    aks                 = azurerm_subnet.aks.id
    postgresql          = azurerm_subnet.postgresql.id
    application_gateway = azurerm_subnet.application_gateway.id
    private_endpoints   = azurerm_subnet.private_endpoints.id
  }
}

output "network_security_group_ids" {
  description = "Network security group IDs keyed by platform role."
  value = {
    aks                 = azurerm_network_security_group.aks.id
    postgresql          = azurerm_network_security_group.postgresql.id
    application_gateway = azurerm_network_security_group.application_gateway.id
  }
}
