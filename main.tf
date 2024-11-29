provider "azurerm" {
  features {}
}

module "my_vpc" {
  source = "./modules/VNet"

  resource_group_name  = "mi-resource-group-for-vnet"
  virtual_network_name = "mi-vnet"
}
