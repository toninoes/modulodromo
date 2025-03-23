# Application Gateway Module
This module manages an Application Gateway.
# Usage
```hcl
module "agw" {
  source = "git::git@github.com:toninoes/modulodromo.git//azure/application-gateway"

  name                = "myappgw"
  resource_group_name = "rg-your-rg-name"

  backend_address_pool = [
    {
      name = "my-backend-address-pool"
    }
  ]

  backend_http_settings = [
    {
      name                  = "my-backend-http-settings"
      cookie_based_affinity = "Disabled"
      path                  = "/path1/"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 60
    }
  ]

  frontend_ip_configuration = [
    {
      name                 = "my-frontend-ip-configuration"
      public_ip_address_id = "public-ip-id"
    }
  ]

  frontend_port = [
    {
      name = "my-frontend-port"
      port = 80
    }
  ]

  gateway_ip_configuration = [
    {
      name      = "my-gateway-ip-configuration"
      subnet_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnetValue"
    }
  ]

  http_listener = [
    {
      name                           = "my-http-listener"
      frontend_ip_configuration_name = "my-frontend-ip-configuration"
      frontend_port_name             = "my-frontend-port-name"
      protocol                       = "Http"
    }
  ]

  request_routing_rule = [
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
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | 4.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_address\_pool | List of backend address pools, each containing a name, FQDNs, and/or IP addresses. | <pre>list(object({<br>    name         = string<br>    fqdns        = optional(list(string), [])<br>    ip_addresses = optional(list(string), [])<br>  }))</pre> | n/a | yes |
| backend\_http\_settings | A list of backend HTTP settings collections, each containing various HTTP settings configurations. | <pre>list(object({<br>    name                           = string<br>    cookie_based_affinity          = string<br>    affinity_cookie_name           = optional(string, null)<br>    path                           = optional(string, null)<br>    port                           = number<br>    probe_name                     = optional(string, null)<br>    protocol                       = string<br>    request_timeout                = optional(number, 30)<br>    host_name                      = optional(string, null)<br>    pick_host_name_from_backend    = optional(bool, false)<br>    trusted_root_certificate_names = optional(list(string), [])<br>  }))</pre> | n/a | yes |
| frontend\_ip\_configuration | List of frontend IP configurations, each containing details for the Application Gateway. | <pre>list(object({<br>    name                            = string<br>    subnet_id                       = optional(string, null)<br>    private_ip_address              = optional(string, null)<br>    public_ip_address_id            = optional(string, null)<br>    private_ip_address_allocation   = optional(string, "Dynamic")<br>    private_link_configuration_name = optional(string, null)<br>  }))</pre> | n/a | yes |
| frontend\_port | List of frontend ports. | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | n/a | yes |
| gateway\_ip\_configuration | List of Gateway IP configurations | <pre>list(object({<br>    name      = string<br>    subnet_id = string<br>  }))</pre> | n/a | yes |
| http\_listener | A list of HTTP listeners for the Application Gateway, specifying their configurations. | <pre>list(object({<br>    name                           = string<br>    frontend_ip_configuration_name = string<br>    frontend_port_name             = string<br>    host_names                     = optional(list(string), [])<br>    protocol                       = optional(string, "Https")<br>    require_sni                    = optional(bool, false)<br>    ssl_certificate_name           = optional(string, null)<br>    firewall_policy_id             = optional(string, null)<br>    ssl_profile_name               = optional(string, null)<br>  }))</pre> | n/a | yes |
| name | Name for Application Gateway. | `string` | n/a | yes |
| request\_routing\_rule | A list of request routing rules, each specifying the configuration for routing requests in the Application Gateway. | <pre>list(object({<br>    name                        = string<br>    rule_type                   = string<br>    http_listener_name          = string<br>    backend_address_pool_name   = optional(string, null)<br>    backend_http_settings_name  = optional(string, null)<br>    redirect_configuration_name = optional(string, null)<br>    rewrite_rule_set_name       = optional(string, null)<br>    url_path_map_name           = optional(string, null)<br>    priority                    = optional(number, null)<br>  }))</pre> | n/a | yes |
| resource\_group\_name | The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created | `string` | n/a | yes |
| sku | Defines the SKU (Stock Keeping Unit) configuration for the Azure Application Gateway. It includes the name, tier, and capacity of the SKU. | <pre>object({<br>    name     = string<br>    tier     = string<br>    capacity = number<br>  })</pre> | <pre>{<br>  "capacity": 2,<br>  "name": "Standard_v2",<br>  "tier": "Standard_v2"<br>}</pre> | no |
| tags | Common tags to be applied to all resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
