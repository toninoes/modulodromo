resource "azurerm_local_network_gateway" "this" {
  location            = data.azurerm_resource_group.this.location
  name                = var.peer_name
  resource_group_name = var.resource_group_name

  address_space   = var.address_space
  gateway_address = var.gateway_address

  tags = var.tags
}

resource "azurerm_virtual_network_gateway_connection" "this" {
  location            = data.azurerm_resource_group.this.location
  name                = var.vnet_gw_conn_name
  resource_group_name = var.resource_group_name

  connection_mode            = var.connection_mode
  connection_protocol        = var.connection_protocol
  local_network_gateway_id   = azurerm_local_network_gateway.this.id
  shared_key                 = var.shared_key
  type                       = "IPsec"
  virtual_network_gateway_id = var.virtual_network_gateway_id

  ipsec_policy {
    dh_group         = var.dh_group
    ike_encryption   = var.ike_encryption
    ike_integrity    = var.ike_integrity
    ipsec_encryption = var.ipsec_encryption
    ipsec_integrity  = var.ipsec_integrity
    pfs_group        = var.pfs_group
    sa_datasize      = var.sa_datasize
    sa_lifetime      = var.sa_lifetime
  }

  tags = var.tags
}