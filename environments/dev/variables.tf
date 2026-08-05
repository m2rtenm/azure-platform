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

variable "tags" {
  description = "Common tags passed to all modules."
  type        = map(string)
  default = {
    environment = "dev"
    managed_by  = "terraform"
    project     = "azure-platform"
  }
}
