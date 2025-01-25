# Azure Virtual Network Module

Manages a virtual network including any configured subnets

## Usage

```hcl
module "vnet" {
  source = "git::git@github.com:toninoes/modulodromo.git//azure/virtual_network"

  address_space       = ["10.0.0.0/16"]
  resource_group_name = "mi-resource-group-for-vnet"
  subnets = [
    {
      name    = "subnet-0"
      address = ["10.0.0.0/24"]
    },
    {
      name    = "subnet-1"
      address = ["10.0.1.0/24"]
    }
  ]
  virtual_network_name = "mi-vnet"
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
| azurerm | 4.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_space | The address space that is used the virtual network. You can supply more than one address space. | `list(string)` | n/a | yes |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `"West Europe"` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created | `string` | n/a | yes |
| subnets | List of subnets with their corresponding names and address prefixes | <pre>list(object({<br>    name    = string<br>    address = list(string)<br>  }))</pre> | `[]` | no |
| tags | Common tags to be applied to all resources | `map(string)` | `{}` | no |
| virtual\_network\_name | The name of the virtual network. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address\_space | The list of address spaces used by the virtual network. |
| guid | The GUID of the virtual network. |
| id | The virtual network configuration ID. |
| location | The location/region where the virtual network is created. |
| name | The name of the virtual network. |
| resource\_group\_name | The name of the resource group in which to create the virtual network. |
| subnet | Blocks containing configuration of each subnet. |

