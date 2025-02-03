output "address_space" {
  value       = azurerm_virtual_network.this.address_space
  description = "The list of address spaces used by the virtual network."
}

output "guid" {
  value       = azurerm_virtual_network.this.guid
  description = "The GUID of the virtual network."
}

output "id" {
  value       = azurerm_virtual_network.this.id
  description = "The virtual network configuration ID."
}

output "location" {
  value       = azurerm_virtual_network.this.location
  description = "The location/region where the virtual network is created."
}

output "name" {
  value       = azurerm_virtual_network.this.name
  description = "The name of the virtual network."
}

output "public_ip_bastion" {
  value       = one(azurerm_public_ip.bastion[*].ip_address)
  description = "Public IP for bastion host."
}

output "public_ip_vpn_gateway" {
  value       = one(azurerm_public_ip.vpn_gateway[*].ip_address)
  description = "Public IP for VPN Gateway."
}

output "resource_group_name" {
  value       = azurerm_virtual_network.this.resource_group_name
  description = "The name of the resource group in which to create the virtual network."
}

output "subnet" {
  value       = { for subnet in azurerm_subnet.this : subnet.name => subnet }
  description = "Blocks containing configuration of each subnet."
}
