resource "azurerm_virtual_network" "this" {
  address_space       = var.address_space
  location            = data.azurerm_resource_group.this.location
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# resource "azurerm_subnet" "this" {
#   for_each = { for subnet in var.subnets : subnet.name => subnet }
#
#   address_prefixes     = each.value.address
#   name                 = "${var.virtual_network_name}-${each.value.name}"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.this.name
# }
#
# resource "azurerm_network_security_group" "this" {
#   for_each = { for subnet in var.subnets : subnet.name => subnet }
#
#   name                = "${var.virtual_network_name}-${each.value.name}-nsg"
#   location            = data.azurerm_resource_group.this.location
#   resource_group_name = var.resource_group_name
# }

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = azurerm_subnet.this

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}