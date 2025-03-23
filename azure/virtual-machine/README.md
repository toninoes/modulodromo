# Azure Virtual Machine

Manages a virtual machine

## Usage

```hcl
module "vm" {
  source = "git::git@github.com:toninoes/modulodromo.git//azure/virtual-machine"

  name                 = "mi-vn-name"
  resource_group_name  = "mi-resource-group-for-vm"
  subnet_name          = "mi-subnet"
  virtual_network_name = "mi-vnet-name"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 4.0 |
| external | >= 2.0 |
| local | >= 2.0 |
| tls | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | 4.16.0 |
| external | 2.3.4 |
| local | 2.5.2 |
| tls | 4.0.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [local_file.pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.pub](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [external_external.myipaddr](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_username | The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | `"adminuser"` | no |
| enable\_public\_ip | Enable public IP to vitual machine | `bool` | `true` | no |
| name | Name to assign to VM | `string` | n/a | yes |
| resource\_group\_name | The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created | `string` | n/a | yes |
| size | The SKU which should be used for this Virtual Machine | `string` | `"Standard_B2s"` | no |
| ss\_oo | Operating System. Linux or windows | `string` | `"linux"` | no |
| ssh\_key\_pairs\_name | Name used to create SSH key pairs. | `string` | `"toninoes"` | no |
| subnet\_name | The name of the subnet where to deploy the VM. | `string` | n/a | yes |
| tags | Common tags to be applied to all resources | `map(string)` | `{}` | no |
| virtual\_network\_name | The name of the virtual network where to deploy the VM. | `string` | n/a | yes |
| windows\_admin\_pass | The Password which should be used for the local-administrator on this Virtual Machine for Windows. Changing this forces a new resource to be created. | `string` | `"P@$$w0rd1234!"` | no |

## Outputs

No outputs.
