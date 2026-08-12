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

module "aks" {
  source = "../../modules/aks"

  location                   = var.location
  resource_group_name        = module.network.resource_group_name
  name_prefix                = local.name_prefix
  subnet_id                  = module.network.subnet_ids.aks
  acr_id                     = module.acr.id
  tenant_id                  = coalesce(var.tenant_id, data.azurerm_client_config.current.tenant_id)
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
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

module "keyvault" {
  source = "../../modules/keyvault"

  location                          = var.location
  resource_group_name               = module.network.resource_group_name
  name_prefix                       = local.name_prefix
  tenant_id                         = data.azurerm_client_config.current.tenant_id
  deployer_object_id                = data.azurerm_client_config.current.object_id
  virtual_network_id                = module.network.vnet_id
  private_endpoint_subnet_id        = module.network.subnet_ids.private_endpoints
  postgresql_administrator_login    = module.postgresql.administrator_login
  postgresql_administrator_password = module.postgresql.administrator_password
  postgresql_fqdn                   = module.postgresql.fqdn
  postgresql_database_name          = module.postgresql.database_name
  sku_name                          = var.key_vault_sku_name
  tags                              = var.tags
}

module "application_gateway" {
  source = "../../modules/application_gateway"

  location                 = var.location
  resource_group_name      = module.network.resource_group_name
  name_prefix              = local.name_prefix
  subnet_id                = module.network.subnet_ids.application_gateway
  ssl_certificate_data     = var.application_gateway_ssl_certificate_data
  ssl_certificate_password = var.application_gateway_ssl_certificate_password
  waf_mode                 = var.application_gateway_waf_mode
  min_capacity             = var.application_gateway_min_capacity
  max_capacity             = var.application_gateway_max_capacity
  tags                     = var.tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  location               = var.location
  resource_group_name    = module.network.resource_group_name
  name_prefix            = local.name_prefix
  retention_in_days      = var.log_analytics_retention_in_days
  aks_id                 = module.aks.id
  postgresql_id          = module.postgresql.id
  key_vault_id           = module.keyvault.id
  application_gateway_id = module.application_gateway.id
  acr_id                 = module.acr.id
  tags                   = var.tags
}
