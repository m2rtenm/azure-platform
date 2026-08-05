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

variable "tags" {
  description = "Common tags passed to all modules."
  type        = map(string)
  default = {
    environment = "dev"
    managed_by  = "terraform"
    project     = "azure-platform"
  }
}
