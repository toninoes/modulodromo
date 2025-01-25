output "private_ip" {
  description = "Private IP of virtual machine"
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip" {
  description = "Public IP of virtual machine"
  value       = var.enable_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "nsg_name" {
  description = "Network Security Group Name"
  value       = azurerm_network_security_group.this.name
}