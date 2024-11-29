output "vnet__name" {
  description = "Name for VNet."
  value       = azurerm_virtual_network.this.name
}

output "vnet_resource_group_name" {
  description = "Resource Group Name for VNet."
  value       = azurerm_virtual_network.this.resource_group_name
}