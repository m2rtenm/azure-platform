output "resource_group_name" {
  description = "Development platform resource group name."
  value       = module.network.resource_group_name
}

output "vnet_id" {
  description = "Development platform virtual network ID."
  value       = module.network.vnet_id
}

output "vnet_name" {
  description = "Development platform virtual network name."
  value       = module.network.vnet_name
}

output "subnet_ids" {
  description = "Subnet IDs keyed by platform role."
  value       = module.network.subnet_ids
}

output "network_security_group_ids" {
  description = "Network security group IDs keyed by platform role."
  value       = module.network.network_security_group_ids
}
