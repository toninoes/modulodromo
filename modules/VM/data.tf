data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = var.virtual_network_resource_group
  virtual_network_name = var.virtual_network_name
}
