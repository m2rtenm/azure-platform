output "id" {
  description = "AKS cluster resource ID."
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "AKS cluster name."
  value       = azurerm_kubernetes_cluster.this.name
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for Kubernetes workload identity federation."
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "control_plane_identity_principal_id" {
  description = "Principal ID of the AKS control-plane managed identity."
  value       = azurerm_user_assigned_identity.control_plane.principal_id
}

output "kubelet_identity_principal_id" {
  description = "Principal ID of the AKS kubelet managed identity."
  value       = azurerm_user_assigned_identity.kubelet.principal_id
}
