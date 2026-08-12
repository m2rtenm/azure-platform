variable "location" {
  description = "Azure region for the Log Analytics workspace."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains monitoring resources."
  type        = string
}

variable "name_prefix" {
  description = "Naming prefix for monitoring resources."
  type        = string
}

variable "retention_in_days" {
  description = "Log Analytics data retention period."
  type        = number
  default     = 30

  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730
    error_message = "retention_in_days must be between 30 and 730."
  }
}

variable "aks_id" {
  description = "AKS cluster resource ID for diagnostic settings."
  type        = string
}

variable "postgresql_id" {
  description = "PostgreSQL Flexible Server resource ID for diagnostic settings."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault resource ID for diagnostic settings."
  type        = string
}

variable "application_gateway_id" {
  description = "Application Gateway resource ID for diagnostic settings."
  type        = string
}

variable "acr_id" {
  description = "Container Registry resource ID for diagnostic settings."
  type        = string
}

variable "tags" {
  description = "Tags applied to monitoring resources."
  type        = map(string)
}
