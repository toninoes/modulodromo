resource "azurerm_subnet" "vpn_gateway" {
  count = (length(var.subnet_addresses_for_vpn_gateway) == 0) ? 0 : 1

  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet_addresses_for_vpn_gateway
}

resource "azurerm_public_ip" "vpn_gateway" {
  count = (length(var.subnet_addresses_for_vpn_gateway) == 0) ? 0 : 1

  name                = "${var.virtual_network_name}-vpn-gateway-ip"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "this" {
  count = (length(var.subnet_addresses_for_vpn_gateway) == 0) ? 0 : 1

  active_active       = false
  enable_bgp          = false
  location            = data.azurerm_resource_group.this.location
  name                = "${var.virtual_network_name}-vpn-gateway"
  resource_group_name = var.resource_group_name
  sku                 = "VpnGw1"
  type                = "Vpn"
  vpn_type            = "RouteBased"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn_gateway[0].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpn_gateway[0].id
  }
}