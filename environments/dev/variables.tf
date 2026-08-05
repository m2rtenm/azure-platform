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

variable "kubernetes_version" {
  description = "Optional AKS Kubernetes version. Leave null to use Azure's default supported version."
  type        = string
  default     = null
  nullable    = true
}

variable "system_node_vm_size" {
  description = "VM size for the always-on AKS system node pool."
  type        = string
  default     = "Standard_B2s"
}

variable "system_node_min" {
  description = "Minimum system node count. Keep at 1 for a working AKS cluster."
  type        = number
  default     = 1
}

variable "system_node_max" {
  description = "Maximum system node count for cluster autoscaling."
  type        = number
  default     = 2
}

variable "user_node_vm_size" {
  description = "VM size for the scale-to-zero AKS user node pool."
  type        = string
  default     = "Standard_B2s"
}

variable "user_node_max" {
  description = "Maximum user node count for cluster autoscaling."
  type        = number
  default     = 2
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
