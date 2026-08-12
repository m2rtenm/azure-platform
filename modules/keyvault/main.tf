resource "random_string" "name_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_user_assigned_identity" "workload" {
  name                = "id-${var.name_prefix}-platform-workload"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_key_vault" "this" {
  name                          = "kv${replace(var.name_prefix, "-", "")}${random_string.name_suffix.result}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = var.sku_name
  rbac_authorization_enabled    = true
  public_network_access_enabled = false
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = true
  tags                          = var.tags
}

resource "azurerm_private_endpoint" "this" {
  name                = "pep-${var.name_prefix}-keyvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${var.name_prefix}-keyvault"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "pdzg-${var.name_prefix}-keyvault"
    private_dns_zone_ids = [azurerm_private_dns_zone.this.id]
  }
}

resource "azurerm_private_dns_zone" "this" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "pdns-${var.name_prefix}-keyvault"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = var.virtual_network_id
  tags                  = var.tags
}

resource "azurerm_role_assignment" "terraform_administrator" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.deployer_object_id
}

resource "azurerm_role_assignment" "workload_secrets_user" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.workload.principal_id
}

resource "azurerm_key_vault_secret" "postgresql_administrator_password" {
  name         = "postgresql-administrator-password"
  value        = var.postgresql_administrator_password
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [azurerm_role_assignment.terraform_administrator]
}

resource "azurerm_key_vault_secret" "postgresql_connection_string" {
  name         = "postgresql-connection-string"
  value        = "postgresql://${var.postgresql_administrator_login}:${var.postgresql_administrator_password}@${var.postgresql_fqdn}:5432/${var.postgresql_database_name}?sslmode=require"
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [azurerm_role_assignment.terraform_administrator]
}
