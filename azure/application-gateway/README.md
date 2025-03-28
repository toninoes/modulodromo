# Application Gateway Module

This module manages an Application Gateway.

# Usage
```hcl
module "agw" {
  source = "git::git@github.com:toninoes/modulodromo.git//azure/application-gateway"

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
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_address\_pools | List of backend address pools, each containing a name, FQDNs, and/or IP addresses. | <pre>list(object({<br>    name         = string<br>    fqdns        = optional(list(string), [])<br>    ip_addresses = optional(list(string), [])<br>  }))</pre> | n/a | yes |
| backend\_http\_settings\_list | A list of backend HTTP settings collections, each containing various HTTP settings configurations. | <pre>list(object({<br>    name                           = string<br>    cookie_based_affinity          = string<br>    affinity_cookie_name           = optional(string, null)<br>    path                           = optional(string, null)<br>    port                           = number<br>    probe_name                     = optional(string, null)<br>    protocol                       = string<br>    request_timeout                = optional(number, 30)<br>    host_name                      = optional(string, null)<br>    pick_host_name_from_backend    = optional(bool, false)<br>    trusted_root_certificate_names = optional(list(string), [])<br>  }))</pre> | n/a | yes |
| create\_public\_ip | Optional public IP to auto create public id | `bool` | `true` | no |
| extra\_frontend\_ip\_configurations | List of frontend IP configurations, each containing details for the Application Gateway. | <pre>list(object({<br>    name                            = string<br>    subnet_id                       = optional(string, null)<br>    private_ip_address              = optional(string, null)<br>    private_ip_address_allocation   = optional(string, "Dynamic")<br>    private_link_configuration_name = optional(string, null)<br>  }))</pre> | `[]` | no |
| frontend\_ip\_configuration\_public\_name | (Optional) The name of the public Frontend IP Configuration.  If not supplied will be inferred from the resource name. | `string` | `null` | no |
| frontend\_ports | List of frontend ports. | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | n/a | yes |
| gateway\_ip\_configurations | List of Gateway IP configurations | <pre>list(object({<br>    name      = string<br>    subnet_id = string<br>  }))</pre> | n/a | yes |
| http\_listeners | A list of HTTP listeners for the Application Gateway, specifying their configurations. | <pre>list(object({<br>    name                           = string<br>    frontend_ip_configuration_name = string<br>    frontend_port_name             = string<br>    host_names                     = optional(list(string), [])<br>    require_sni                    = optional(bool, false)<br>    ssl_certificate_name           = optional(string, null)<br>    firewall_policy_id             = optional(string, null)<br>    ssl_profile_name               = optional(string, null)<br>  }))</pre> | n/a | yes |
| name | Name for Application Gateway. | `string` | n/a | yes |
| request\_routing\_rules | A list of request routing rules, each specifying the configuration for routing requests in the Application Gateway. | <pre>list(object({<br>    name                        = string<br>    rule_type                   = string<br>    http_listener_name          = string<br>    backend_address_pool_name   = optional(string, null)<br>    backend_http_settings_name  = optional(string, null)<br>    redirect_configuration_name = optional(string, null)<br>    rewrite_rule_set_name       = optional(string, null)<br>    url_path_map_name           = optional(string, null)<br>    priority                    = optional(number, null)<br>  }))</pre> | n/a | yes |
| resource\_group\_name | The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created | `string` | n/a | yes |
| sku | Defines the SKU (Stock Keeping Unit) configuration for the Azure Application Gateway. It includes the name, tier, and capacity of the SKU. | <pre>object({<br>    name     = string<br>    tier     = string<br>    capacity = number<br>  })</pre> | <pre>{<br>  "capacity": 2,<br>  "name": "Standard_v2",<br>  "tier": "Standard_v2"<br>}</pre> | no |
| ssl\_policy\_name | SSL policy name for the Application Gateway | `string` | `"AppGwSslPolicy20220101S"` | no |
| tags | Common tags to be applied to all resources | `map(string)` | `{}` | no |
| waf\_configuration | Application Gateway WAF configuration | <pre>object({<br>    enabled          = optional(bool, true)<br>    firewall_mode    = optional(string, "Prevention")<br>    rule_set_type    = optional(string, "OWASP")<br>    rule_set_version = optional(string, "3.2")<br>  })</pre> | `null` | no |
| zones | (Optional) Specifies a list of Availability Zones in which this Application Gateway should be located. Changing this forces a new Application Gateway to be created. | `set(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| agw\_id | The ID of the Application Gateway. |
