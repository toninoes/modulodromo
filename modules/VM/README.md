# Azure Virtual Machine

Manages a virtual machine

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
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_pass | The Password which should be used for the local-administrator on this Virtual Machine for Windows. Changing this forces a new resource to be created. | `string` | `"P@$$w0rd1234!"` | no |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `"West Europe"` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created | `string` | n/a | yes |
| ss\_oo | Operating System. Linux or windows | `string` | `"linux"` | no |
| subnet\_name | The name of the subnet where to deploy the VM. | `string` | n/a | yes |
| tags | Common tags to be applied to all resources | `map(string)` | `{}` | no |
| virtual\_network\_name | The name of the virtual network where to deploy the VM. | `string` | n/a | yes |
| virtual\_network\_resource\_group | The name of the resource group for virtual network where to deploy virtual machine. | `string` | n/a | yes |
| vm\_name | The name of the Windows Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

No outputs.
