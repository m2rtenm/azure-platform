variable "location" {
  description = "Azure region for Key Vault resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains Key Vault resources."
  type        = string
}

variable "name_prefix" {
  description = "Naming prefix for Key Vault resources."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID for the Key Vault."
  type        = string
}

variable "deployer_object_id" {
  description = "Object ID granted Key Vault Administrator for Terraform secret management."
  type        = string
}

variable "virtual_network_id" {
  description = "Virtual network ID linked to the Key Vault private DNS zone."
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID used by the Key Vault private endpoint."
  type        = string
}

variable "postgresql_administrator_login" {
  description = "PostgreSQL administrator login included in the connection-string secret."
  type        = string
}

variable "postgresql_administrator_password" {
  description = "Sensitive PostgreSQL administrator password stored as a Key Vault secret."
  type        = string
  sensitive   = true
}

variable "postgresql_fqdn" {
  description = "Private PostgreSQL server FQDN included in the connection-string secret."
  type        = string
}

variable "postgresql_database_name" {
  description = "PostgreSQL database name included in the connection-string secret."
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "sku_name must be standard or premium."
  }
}

variable "soft_delete_retention_days" {
  description = "Number of days deleted Key Vault objects are retained."
  type        = number
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "tags" {
  description = "Tags applied to Key Vault resources."
  type        = map(string)
}
