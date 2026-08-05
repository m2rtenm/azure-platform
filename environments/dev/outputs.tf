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

output "acr_id" {
  description = "Azure Container Registry resource ID."
  value       = module.acr.id
}

output "acr_login_server" {
  description = "Container image registry hostname."
  value       = module.acr.login_server
}

output "acr_name" {
  description = "Globally unique Azure Container Registry name."
  value       = module.acr.name
}

output "aks_cluster_id" {
  description = "AKS cluster resource ID."
  value       = module.aks.id
}

output "aks_cluster_name" {
  description = "AKS cluster name."
  value       = module.aks.name
}

output "aks_oidc_issuer_url" {
  description = "OIDC issuer URL for Kubernetes workload identity federation."
  value       = module.aks.oidc_issuer_url
}

output "aks_control_plane_identity_principal_id" {
  description = "Principal ID of the AKS control-plane managed identity."
  value       = module.aks.control_plane_identity_principal_id
}

output "aks_kubelet_identity_principal_id" {
  description = "Principal ID of the AKS kubelet managed identity."
  value       = module.aks.kubelet_identity_principal_id
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace resource ID used by AKS Container Insights."
  value       = azurerm_log_analytics_workspace.aks.id
}
