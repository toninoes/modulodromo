resource "azurerm_virtual_network" "this" {
  address_space       = var.address_space
  location            = data.azurerm_resource_group.this.location
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  address_prefixes     = each.value.address
  name                 = "${var.virtual_network_name}-${each.value.name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
}

resource "azurerm_subnet" "bastion" {
  count = (length(var.subnet_addresses_for_bastion) == 0) ? 0 : 1

  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet_addresses_for_bastion
}

resource "azurerm_public_ip" "bastion" {
  count = (length(var.subnet_addresses_for_bastion) == 0) ? 0 : 1

  name                = "${var.virtual_network_name}-bastion-ip"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Stardard"
}

resource "azurerm_bastion_host" "this" {
  count = (length(var.subnet_addresses_for_bastion) == 0) ? 0 : 1

  name                = "${var.virtual_network_name}-bastion"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion[0].id
    public_ip_address_id = azurerm_public_ip.bastion[0].id
  }
}