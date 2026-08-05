locals {
  name_prefix = "azplat-${var.environment}"
}

data "azurerm_client_config" "current" {}

module "network" {
  source = "../../modules/network"

  location            = var.location
  resource_group_name = var.resource_group_name
  name_prefix         = local.name_prefix
  vnet_address_space  = var.vnet_address_space
  tags                = var.tags
}

module "acr" {
  source = "../../modules/acr"

  location            = var.location
  resource_group_name = module.network.resource_group_name
  name_prefix         = local.name_prefix
  sku                 = var.acr_sku
  tags                = var.tags
}

resource "azurerm_log_analytics_workspace" "aks" {
  name                = "log-${local.name_prefix}-aks"
  location            = var.location
  resource_group_name = module.network.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_analytics_retention_in_days
  tags                = var.tags
}

module "aks" {
  source = "../../modules/aks"

  location                   = var.location
  resource_group_name        = module.network.resource_group_name
  name_prefix                = local.name_prefix
  subnet_id                  = module.network.subnet_ids.aks
  acr_id                     = module.acr.id
  tenant_id                  = coalesce(var.tenant_id, data.azurerm_client_config.current.tenant_id)
  log_analytics_workspace_id = azurerm_log_analytics_workspace.aks.id
  kubernetes_version         = var.kubernetes_version
  sku_tier                   = var.aks_sku_tier
  system_node_pool           = var.aks_system_node_pool
  user_node_pool             = var.aks_user_node_pool
  tags                       = var.tags
}

module "postgresql" {
  source = "../../modules/postgresql"

  location              = var.location
  resource_group_name   = module.network.resource_group_name
  name_prefix           = local.name_prefix
  virtual_network_id    = module.network.vnet_id
  delegated_subnet_id   = module.network.subnet_ids.postgresql
  administrator_login   = var.postgresql_administrator_login
  database_name         = var.postgresql_database_name
  postgresql_version    = var.postgresql_version
  sku_name              = var.postgresql_sku_name
  storage_mb            = var.postgresql_storage_mb
  backup_retention_days = var.postgresql_backup_retention_days
  zone                  = var.postgresql_zone
  tags                  = var.tags
}
