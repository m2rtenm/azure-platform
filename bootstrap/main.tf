resource "azurerm_resource_group" "terraform_state" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Storage account names are globally unique. Keeping the random suffix in state
# makes its value stable across future applies.
resource "random_string" "storage_account_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_storage_account" "terraform_state" {
  name                = "${var.storage_account_name_prefix}${random_string.storage_account_suffix.result}"
  resource_group_name = azurerm_resource_group.terraform_state.name
  location            = azurerm_resource_group.terraform_state.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true

  blob_properties {
    versioning_enabled       = true
    change_feed_enabled      = false
    last_access_time_enabled = false
  }

  tags = var.tags
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.terraform_state.id
  container_access_type = "private"
}
