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
