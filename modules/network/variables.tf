variable "location" {
  description = "Azure region for all network resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains network resources."
  type        = string
}

variable "name_prefix" {
  description = "Naming prefix for network resources."
  type        = string
}

variable "vnet_address_space" {
  description = "Address spaces assigned to the virtual network."
  type        = list(string)

  validation {
    condition     = length(var.vnet_address_space) > 0
    error_message = "vnet_address_space must contain at least one CIDR block."
  }
}

variable "tags" {
  description = "Tags applied to supported network resources."
  type        = map(string)
}
