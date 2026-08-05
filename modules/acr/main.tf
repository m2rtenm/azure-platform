# Registry names must be globally unique and use only alphanumeric characters.
resource "random_string" "name_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_container_registry" "this" {
  name                = "acr${replace(var.name_prefix, "-", "")}${random_string.name_suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  admin_enabled                 = false
  anonymous_pull_enabled        = false
  data_endpoint_enabled         = false
  public_network_access_enabled = true
  tags                          = var.tags
}
