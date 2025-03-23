variables {
  name                = "myappgw"
  resource_group_name = "rg-your-rg-name"

  backend_address_pools = [
    {
      name = "my-backend-address-pool"
    }
  ]

  backend_http_settings_list = [
    {
      name                  = "my-backend-http-settings"
      cookie_based_affinity = "Disabled"
      path                  = "/path1/"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 60
    }
  ]

  frontend_ip_configurations = [
    {
      name                 = "my-frontend-ip-configuration"
      public_ip_address_id = "public-ip-id"
    }
  ]

  frontend_ports = [
    {
      name = "my-frontend-port"
      port = 80
    }
  ]

  gateway_ip_configurations = [
    {
      name      = "my-gateway-ip-configuration"
      subnet_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnetValue"
    }
  ]

  http_listeners = [
    {
      name                           = "my-http-listener"
      frontend_ip_configuration_name = "my-frontend-ip-configuration"
      frontend_port_name             = "my-frontend-port-name"
      protocol                       = "Http"
    }
  ]

  request_routing_rules = [
    {
      name                       = "my-request-routing-rule"
      priority                   = 9
      rule_type                  = "Basic"
      http_listener_name         = "my-http-listener"
      backend_address_pool_name  = "my-backend-address-pool"
      backend_http_settings_name = "my-backend-http-settings"
    }
  ]
}

mock_provider "azurerm" {}

run "create_application_gateway" {
  command = plan

  # TODO: We can implement some tests here
}
