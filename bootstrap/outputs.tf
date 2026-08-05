output "resource_group_name" {
  description = "Resource group containing the remote-state backend."
  value       = azurerm_resource_group.terraform_state.name
}

output "storage_account_name" {
  description = "Globally unique storage account name for Terraform remote state."
  value       = azurerm_storage_account.terraform_state.name
}

output "container_name" {
  description = "Private blob container used for Terraform state."
  value       = azurerm_storage_container.terraform_state.name
}

output "backend_config" {
  description = "Values needed to configure an azurerm Terraform backend in later stacks."
  value = {
    resource_group_name  = azurerm_resource_group.terraform_state.name
    storage_account_name = azurerm_storage_account.terraform_state.name
    container_name       = azurerm_storage_container.terraform_state.name
  }
}
