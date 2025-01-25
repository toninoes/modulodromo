resource "azurerm_resource_group" "this" {
  location = var.location
  name     = var.resource_group_name
  tags     = var.tags
}

resource "azurerm_virtual_network" "this" {
  address_space       = var.address_space
  location            = azurerm_resource_group.this.location
  name                = var.virtual_network_name
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  address_prefixes     = each.value.address
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}