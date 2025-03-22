output "local_network_gateway_id" {
  description = "The ID of the Local Network Gateway."
  value       = azurerm_local_network_gateway.this.id
}

output "virtual_network_gateway_connection_id" {
  description = "The ID of the Virtual Network Gateway Connection."
  value       = azurerm_virtual_network_gateway_connection.this.id
}
