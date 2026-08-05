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
