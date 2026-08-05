locals {
  name_prefix = "azplat-${var.environment}"
}

module "network" {
  source = "../../modules/network"

  location            = var.location
  resource_group_name = var.resource_group_name
  name_prefix         = local.name_prefix
  vnet_address_space  = var.vnet_address_space
  tags                = var.tags
}

module "acr" {
  source = "../../modules/acr"

  location            = var.location
  resource_group_name = module.network.resource_group_name
  name_prefix         = local.name_prefix
  sku                 = var.acr_sku
  tags                = var.tags
}

module "aks" {
  source = "../../modules/aks"

  location            = var.location
  resource_group_name = module.network.resource_group_name
  name_prefix         = local.name_prefix
  kubernetes_version  = var.kubernetes_version
  system_node_vm_size = var.system_node_vm_size
  system_node_min     = var.system_node_min
  system_node_max     = var.system_node_max
  user_node_vm_size   = var.user_node_vm_size
  user_node_max       = var.user_node_max
  aks_subnet_id       = module.network.subnet_ids.aks
  acr_id              = module.acr.id
  tags                = var.tags
}
