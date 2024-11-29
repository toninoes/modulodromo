# Azure Virtual Network Module

Manages a virtual network including any configured subnets

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_space | The address space that is used the virtual network. You can supply more than one address space. | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `"West Europe"` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created | `string` | n/a | yes |
| subnets | Map of subnets with their corresponding names and address prefixes | <pre>map(object({<br>    name    = string<br>    address = string<br>  }))</pre> | <pre>{<br>  "subnet1": {<br>    "address": "10.0.1.0/24",<br>    "name": "subnet1"<br>  },<br>  "subnet2": {<br>    "address": "10.0.2.0/24",<br>    "name": "subnet2"<br>  }<br>}</pre> | no |
| virtual\_network\_name | The name of the virtual network. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

No outputs.
