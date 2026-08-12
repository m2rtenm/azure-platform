variable "location" {
  description = "Azure region used by the development platform."
  type        = string
  default     = "northeurope"
}

variable "environment" {
  description = "Environment name used in resource names and tags."
  type        = string
  default     = "dev"
}

variable "subscription_id" {
  description = "Optional Azure subscription ID. Leave null to use the selected Azure CLI subscription."
  type        = string
  default     = null
  nullable    = true
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID used for Azure RBAC in AKS. Leave null to use the Azure CLI tenant."
  type        = string
  default     = null
  nullable    = true
}

variable "resource_group_name" {
  description = "Resource group that contains the development platform resources."
  type        = string
  default     = "rg-azplat-dev-neu"
}

variable "vnet_address_space" {
  description = "CIDR range for the development platform virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "acr_sku" {
  description = "Azure Container Registry SKU. Basic is the low-cost development default."
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "acr_sku must be Basic, Standard, or Premium."
  }
}

variable "log_analytics_retention_in_days" {
  description = "Retention period for AKS Container Insights logs."
  type        = number
  default     = 30

  validation {
    condition     = var.log_analytics_retention_in_days >= 30 && var.log_analytics_retention_in_days <= 730
    error_message = "log_analytics_retention_in_days must be between 30 and 730."
  }
}

variable "kubernetes_version" {
  description = "Optional AKS version. Leave null to use Azure's default supported version."
  type        = string
  default     = null
  nullable    = true
}

variable "aks_sku_tier" {
  description = "AKS SKU tier. Free is suitable for the development environment."
  type        = string
  default     = "Free"

  validation {
    condition     = contains(["Free", "Standard", "Premium"], var.aks_sku_tier)
    error_message = "aks_sku_tier must be Free, Standard, or Premium."
  }
}

variable "aks_system_node_pool" {
  description = "System node pool configuration."
  type = object({
    vm_size         = string
    min_count       = number
    max_count       = number
    os_disk_size_gb = number
  })
  default = {
    vm_size         = "Standard_B2s"
    min_count       = 1
    max_count       = 2
    os_disk_size_gb = 30
  }
}

variable "aks_user_node_pool" {
  description = "User node pool configuration."
  type = object({
    vm_size         = string
    min_count       = number
    max_count       = number
    os_disk_size_gb = number
  })
  default = {
    vm_size         = "Standard_B2s"
    min_count       = 0
    max_count       = 2
    os_disk_size_gb = 30
  }
}

variable "postgresql_administrator_login" {
  description = "PostgreSQL administrator login name."
  type        = string
  default     = "pgadmin"
}

variable "postgresql_database_name" {
  description = "Initial database name for platform workloads."
  type        = string
  default     = "platform"
}

variable "postgresql_version" {
  description = "PostgreSQL Flexible Server major version."
  type        = string
  default     = "16"

  validation {
    condition     = contains(["14", "15", "16", "17"], var.postgresql_version)
    error_message = "postgresql_version must be a supported Azure PostgreSQL Flexible Server version."
  }
}

variable "postgresql_sku_name" {
  description = "PostgreSQL Flexible Server SKU. The default is a low-cost development SKU."
  type        = string
  default     = "B_Standard_B1ms"
}

variable "postgresql_storage_mb" {
  description = "PostgreSQL storage allocation in megabytes."
  type        = number
  default     = 32768

  validation {
    condition     = var.postgresql_storage_mb >= 32768
    error_message = "postgresql_storage_mb must be at least 32768."
  }
}

variable "postgresql_backup_retention_days" {
  description = "PostgreSQL backup retention period in days."
  type        = number
  default     = 7

  validation {
    condition     = var.postgresql_backup_retention_days >= 7 && var.postgresql_backup_retention_days <= 35
    error_message = "postgresql_backup_retention_days must be between 7 and 35."
  }
}

variable "postgresql_zone" {
  description = "Availability zone for PostgreSQL. Set null where zones are unavailable."
  type        = string
  default     = "1"
  nullable    = true
}

variable "key_vault_sku_name" {
  description = "Key Vault SKU. Standard is sufficient for secret storage."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.key_vault_sku_name)
    error_message = "key_vault_sku_name must be standard or premium."
  }
}

variable "application_gateway_ssl_certificate_data" {
  description = "Base64-encoded PFX certificate for the Application Gateway HTTPS listener."
  type        = string
  sensitive   = true
  nullable    = false
}

variable "application_gateway_ssl_certificate_password" {
  description = "Password for the Application Gateway HTTPS listener PFX certificate."
  type        = string
  sensitive   = true
  nullable    = false
}

variable "application_gateway_waf_mode" {
  description = "Application Gateway WAF mode."
  type        = string
  default     = "Prevention"

  validation {
    condition     = contains(["Detection", "Prevention"], var.application_gateway_waf_mode)
    error_message = "application_gateway_waf_mode must be Detection or Prevention."
  }
}

variable "application_gateway_min_capacity" {
  description = "Minimum Application Gateway WAF v2 capacity."
  type        = number
  default     = 1
}

variable "application_gateway_max_capacity" {
  description = "Maximum Application Gateway WAF v2 capacity."
  type        = number
  default     = 2
}

variable "github_actions_subject" {
  description = "Exact GitHub Actions OIDC subject trusted by the platform delivery identity."
  type        = string
  default     = "repo:m2rtenm/azure-platform:environment:dev"
}

variable "tags" {
  description = "Common tags passed to all modules."
  type        = map(string)
  default = {
    environment = "dev"
    managed_by  = "terraform"
    project     = "azure-platform"
  }
}
