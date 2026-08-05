output "cluster_id" {
  value       = azurerm_kubernetes_cluster.this.id
  description = "AKS resource ID."
}
output "cluster_name" {
  value       = azurerm_kubernetes_cluster.this.name
  description = "AKS cluster name."
}
output "oidc_issuer_url" {
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
  description = "OIDC issuer URL."
}
output "identity_principal_id" {
  value       = azurerm_user_assigned_identity.this.principal_id
  description = "AKS user-assigned identity principal ID."
}
