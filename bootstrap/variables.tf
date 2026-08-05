variable "location" {
  description = "Azure region for the Terraform state resources."
  type        = string
  default     = "northeurope"
}

variable "resource_group_name" {
  description = "Name of the resource group that contains the Terraform state storage account."
  type        = string
  default     = "rg-tfstate-dev-neu"

  validation {
    condition     = can(regex("^[0-9A-Za-z_.()-]{1,90}$", var.resource_group_name))
    error_message = "resource_group_name must be 1-90 valid Azure resource-group characters."
  }
}

variable "storage_account_name_prefix" {
  description = "Lowercase prefix for the globally unique state storage-account name; a random suffix is appended."
  type        = string
  default     = "sttfstate"

  validation {
    condition     = can(regex("^[a-z0-9]{3,18}$", var.storage_account_name_prefix))
    error_message = "storage_account_name_prefix must be 3-18 lowercase letters or numbers."
  }
}

variable "container_name" {
  description = "Private blob container that stores Terraform state files."
  type        = string
  default     = "tfstate"
}

variable "subscription_id" {
  description = "Optional Azure subscription ID. Leave null to use the subscription selected in Azure CLI."
  type        = string
  default     = null
  nullable    = true
}

variable "tags" {
  description = "Tags applied to all supported bootstrap resources."
  type        = map(string)
  default = {
    environment = "shared"
    managed_by  = "terraform"
    project     = "azure-platform"
    purpose     = "terraform-state"
  }
}
