variable "location" {
  description = "Azure region for Application Gateway resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains Application Gateway resources."
  type        = string
}

variable "name_prefix" {
  description = "Naming prefix for Application Gateway resources."
  type        = string
}

variable "subnet_id" {
  description = "Dedicated Application Gateway subnet ID."
  type        = string
}

variable "ssl_certificate_data" {
  description = "Base64-encoded PFX certificate used by the HTTPS listener."
  type        = string
  sensitive   = true
}

variable "ssl_certificate_password" {
  description = "Password for the HTTPS listener PFX certificate."
  type        = string
  sensitive   = true
}

variable "waf_mode" {
  description = "WAF operating mode."
  type        = string
  default     = "Prevention"

  validation {
    condition     = contains(["Detection", "Prevention"], var.waf_mode)
    error_message = "waf_mode must be Detection or Prevention."
  }
}

variable "min_capacity" {
  description = "Minimum WAF v2 instance capacity."
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum WAF v2 instance capacity."
  type        = number
  default     = 2
}

variable "zones" {
  description = "Availability zones for zonal Application Gateway resources."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "tags" {
  description = "Tags applied to Application Gateway resources."
  type        = map(string)
}
