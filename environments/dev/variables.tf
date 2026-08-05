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

variable "tags" {
  description = "Common tags passed to all modules."
  type        = map(string)
  default = {
    environment = "dev"
    managed_by  = "terraform"
    project     = "azure-platform"
  }
}
