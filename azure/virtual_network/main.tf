resource "azurerm_virtual_network" "this" {
  address_space       = var.address_space
  location            = data.azurerm_resource_group.this.location
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.this.name
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  address_prefixes     = each.value.address
  name                 = "${var.virtual_network_name}-${each.value.name}"
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}
