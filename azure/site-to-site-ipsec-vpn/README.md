# Site-to-Site IPsec VPN

Manages a Site-to-Site IPsec VPN.

## What is a Site-to-Site VPN? 

A Site-to-Site VPN (Virtual Private Network) is a connection that allows us to securely link two networks over the internet. 
It extends our on-premises network into the cloud, making resources in both networks appear as if they're on the same local 
network.

## What is IPsec?
IPsec (Internet Protocol Security) is a protocol suite used to secure internet communications. It works by encrypting each 
IP packet in a data stream, providing confidentiality, integrity, and authentication of data communications over IP networks. 

## Usage

```hcl
module "ipsec_vpn" {
  source = "git::git@github.com:toninoes/modulodromo.git//azure/site-to-site-ipsec-vpn"

  address_space              = ["10.0.0.0/16", "10.1.0.0/16"]
  gateway_address            = "123.123.123.123"
  peer_name                  = "name-assigned-to-other-peer"
  resource_group_name        = "rg-your-rg-name"
  shared_key                 = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
  virtual_network_gateway_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworkGateways/virtualNetworkGatewayName"
  vnet_gw_conn_name          = "mi-vnet-gw"
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
| azurerm | 4.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_local_network_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_space | The list of string CIDRs representing the address spaces the gateway exposes. Info provided by the other side of the VPN tunnel. | `list(string)` | n/a | yes |
| connection\_mode | Connection mode to use. Possible values are Default, InitiatorOnly and ResponderOnly. | `string` | `"Default"` | no |
| connection\_protocol | The IKE protocol version to use. Possible values are IKEv1 and IKEv2. | `string` | `"IKEv2"` | no |
| dh\_group | The DH group used in IKE phase 1 for initial SA. Valid options are DHGroup1, DHGroup14, DHGroup2, DHGroup2048, DHGroup24, ECP256, ECP384, or None. | `string` | `"DHGroup24"` | no |
| gateway\_address | The gateway IP address to connect with. Info provided by the other side of the VPN tunnel. | `string` | n/a | yes |
| ike\_encryption | The IKE encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, or GCMAES256. | `string` | `"GCMAES256"` | no |
| ike\_integrity | The IKE integrity algorithm. Valid options are GCMAES128, GCMAES256, MD5, SHA1, SHA256, or SHA384. | `string` | `"SHA384"` | no |
| ipsec\_encryption | The IPSec encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256, or None. | `string` | `"GCMAES256"` | no |
| ipsec\_integrity | The IPSec integrity algorithm. Valid options are GCMAES128, GCMAES192, GCMAES256, MD5, SHA1, or SHA256. | `string` | `"GCMAES256"` | no |
| peer\_name | A name you assigned to the other side of the VPN tunnel. | `string` | n/a | yes |
| pfs\_group | The DH group used in IKE phase 2 for new child SA. Valid options are ECP256, ECP384, PFS1, PFS14, PFS2, PFS2048, PFS24, PFSMM, or None. | `string` | `"None"` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created | `string` | n/a | yes |
| sa\_datasize | The IPSec SA payload size in KB. Must be at least 1024 KB. Defaults to 102400000 KB. | `number` | `102400000` | no |
| sa\_lifetime | The IPSec SA lifetime in seconds. Must be at least 300 seconds. Defaults to 27000 seconds. | `number` | `27000` | no |
| shared\_key | The shared IPSec key. Should be the same in both sides of the VPN tunnel. | `string` | n/a | yes |
| tags | Common tags to be applied to all resources | `map(string)` | `{}` | no |
| virtual\_network\_gateway\_id | The ID of the Virtual Network Gateway in which the connection will be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| vnet\_gw\_conn\_name | The name of the connection. Changing the name forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| local\_network\_gateway\_id | The ID of the Local Network Gateway. |
| virtual\_network\_gateway\_connection\_id | The ID of the Virtual Network Gateway Connection. |
