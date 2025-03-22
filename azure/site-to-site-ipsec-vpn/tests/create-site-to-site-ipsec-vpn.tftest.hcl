variables {
  address_space              = ["10.0.0.0/16", "10.1.0.0/16"]
  gateway_address            = "123.123.123.123"
  peer_name                  = "name-assigned-to-other-peer"
  resource_group_name        = "rg-your-rg-name"
  shared_key                 = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
  virtual_network_gateway_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworkGateways/virtualNetworkGatewayName"
  vnet_gw_conn_name          = "mi-vnet-gw"
}

mock_provider "azurerm" {}

provider "azurerm" {
  alias = "mocked"
}

run "create_site_to_site_ipsec_vpn" {
  command = plan

  # TODO: We can implement some tests here
}
