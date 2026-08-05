variable "location" {
  description = "Azure region for the container registry."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains the container registry."
  type        = string
}

variable "name_prefix" {
  description = "Naming prefix used to derive the globally unique registry name."
  type        = string
}

variable "sku" {
  description = "Container Registry SKU."
  type        = string

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must be Basic, Standard, or Premium."
  }
}

variable "tags" {
  description = "Tags applied to the registry."
  type        = map(string)
}
