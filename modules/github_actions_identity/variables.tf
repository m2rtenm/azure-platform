variable "location" {
  description = "Azure region for the GitHub Actions managed identity."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains the managed identity."
  type        = string
}

variable "resource_group_id" {
  description = "Resource group scope where Terraform is allowed to manage platform resources."
  type        = string
}

variable "name_prefix" {
  description = "Naming prefix for the managed identity."
  type        = string
}

variable "github_actions_subject" {
  description = "Exact GitHub Actions OIDC subject allowed to exchange a token."
  type        = string
}

variable "acr_id" {
  description = "ACR scope where the delivery workflow may push images."
  type        = string
}

variable "tags" {
  description = "Tags applied to the managed identity."
  type        = map(string)
}
