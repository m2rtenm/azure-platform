provider "azurerm" {
  features {}

  # Leave this null to use the subscription selected by `az login` / `az account set`.
  subscription_id = var.subscription_id
}
