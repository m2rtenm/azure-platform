output "id" {
  description = "Application Gateway resource ID."
  value       = azurerm_application_gateway.this.id
}

output "name" {
  description = "Application Gateway name."
  value       = azurerm_application_gateway.this.name
}

output "public_ip_address" {
  description = "Public IP address assigned to Application Gateway."
  value       = azurerm_public_ip.this.ip_address
}

output "waf_policy_id" {
  description = "Web Application Firewall policy resource ID."
  value       = azurerm_web_application_firewall_policy.this.id
}
