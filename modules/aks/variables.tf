variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "name_prefix" { type = string }
variable "kubernetes_version" {
  type     = string
  default  = null
  nullable = true
}
variable "system_node_vm_size" { type = string }
variable "system_node_min" { type = number }
variable "system_node_max" { type = number }
variable "user_node_vm_size" { type = string }
variable "user_node_max" { type = number }
variable "aks_subnet_id" { type = string }
variable "acr_id" { type = string }
variable "tags" { type = map(string) }
