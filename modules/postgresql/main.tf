resource "random_password" "administrator" {
  length  = 32
  special = true
}

resource "azurerm_private_dns_zone" "this" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "pdns-${var.name_prefix}-postgresql"
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                          = "psql-${var.name_prefix}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.postgresql_version
  delegated_subnet_id           = var.delegated_subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.this.id
  administrator_login           = var.administrator_login
  administrator_password        = random_password.administrator.result
  zone                          = var.zone
  storage_mb                    = var.storage_mb
  sku_name                      = var.sku_name
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = false
  public_network_access_enabled = false
  auto_grow_enabled             = true

  authentication {
    active_directory_auth_enabled = false
    password_auth_enabled         = true
  }

  maintenance_window {
    day_of_week  = 0
    start_hour   = 3
    start_minute = 0
  }

  dynamic "high_availability" {
    for_each = var.high_availability_enabled ? [var.standby_availability_zone] : []

    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = high_availability.value
    }
  }

  tags = var.tags

  depends_on = [azurerm_private_dns_zone_virtual_network_link.this]
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
