variable "location" {
  description = "Azure region for the AKS cluster."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains the AKS cluster."
  type        = string
}

variable "name_prefix" {
  description = "Naming prefix for AKS resources."
  type        = string
}

variable "subnet_id" {
  description = "Subnet resource ID for AKS nodes."
  type        = string
}

variable "acr_id" {
  description = "Resource ID of the Azure Container Registry that AKS may pull from."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID used by Azure RBAC."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace used by AKS monitoring."
  type        = string
}

variable "kubernetes_version" {
  description = "Optional AKS version. Set null to use the Azure default supported version."
  type        = string
  default     = null
  nullable    = true
}

variable "sku_tier" {
  description = "AKS SKU tier."
  type        = string
  default     = "Free"

  validation {
    condition     = contains(["Free", "Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be Free, Standard, or Premium."
  }
}

variable "automatic_channel_upgrade" {
  description = "AKS automatic upgrade channel."
  type        = string
  default     = "patch"

  validation {
    condition     = contains(["patch", "rapid", "node-image", "stable"], var.automatic_channel_upgrade)
    error_message = "automatic_channel_upgrade must be patch, rapid, node-image, or stable."
  }
}

variable "pod_cidr" {
  description = "Non-overlapping CIDR used by Azure CNI Overlay pods."
  type        = string
  default     = "10.244.0.0/16"
}

variable "service_cidr" {
  description = "Non-overlapping CIDR used by Kubernetes services."
  type        = string
  default     = "10.2.0.0/24"
}

variable "dns_service_ip" {
  description = "DNS service IP contained in service_cidr."
  type        = string
  default     = "10.2.0.10"
}

variable "system_node_pool" {
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

variable "user_node_pool" {
  description = "User workload node pool configuration."
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
  description = "Tags applied to AKS resources."
  type        = map(string)
}
