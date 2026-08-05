variable "location" {
  description = "Azure region for PostgreSQL resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains PostgreSQL resources."
  type        = string
}

variable "name_prefix" {
  description = "Naming prefix for PostgreSQL resources."
  type        = string
}

variable "virtual_network_id" {
  description = "Virtual network ID linked to the PostgreSQL private DNS zone."
  type        = string
}

variable "delegated_subnet_id" {
  description = "Delegated subnet ID for the PostgreSQL Flexible Server."
  type        = string
}

variable "administrator_login" {
  description = "PostgreSQL administrator login name."
  type        = string
  default     = "pgadmin"
}

variable "database_name" {
  description = "Initial application database name."
  type        = string
  default     = "platform"
}

variable "postgresql_version" {
  description = "PostgreSQL major version."
  type        = string
  default     = "16"

  validation {
    condition     = contains(["14", "15", "16", "17"], var.postgresql_version)
    error_message = "postgresql_version must be a supported Azure PostgreSQL Flexible Server version."
  }
}

variable "sku_name" {
  description = "PostgreSQL Flexible Server SKU."
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_mb" {
  description = "Allocated storage in megabytes."
  type        = number
  default     = 32768

  validation {
    condition     = var.storage_mb >= 32768
    error_message = "storage_mb must be at least 32768."
  }
}

variable "backup_retention_days" {
  description = "Backup retention period in days."
  type        = number
  default     = 7

  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <= 35
    error_message = "backup_retention_days must be between 7 and 35."
  }
}

variable "zone" {
  description = "Availability zone for the primary server. Set null where zones are unavailable."
  type        = string
  default     = "1"
  nullable    = true
}

variable "high_availability_enabled" {
  description = "Whether to enable zone-redundant high availability."
  type        = bool
  default     = false
}

variable "standby_availability_zone" {
  description = "Availability zone for the standby server when high availability is enabled."
  type        = string
  default     = null
  nullable    = true
}

variable "tags" {
  description = "Tags applied to PostgreSQL resources."
  type        = map(string)
}
