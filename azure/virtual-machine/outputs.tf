output "private_ip" {
  description = "Private IP of virtual machine."
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip" {
  description = "Public IP of virtual machine."
  value       = one(azurerm_public_ip.this[*].ip_address)
}

output "nsg_name" {
  description = "Network Security Group Name."
  value       = azurerm_network_security_group.this.name
}

output "ssh_key_private_name" {
  description = "Filename for private key file."
  value       = one(local_file.pem[*].filename)
}

output "ssh_key_public_name" {
  description = "Filename for public key file."
  value       = one(local_file.pub[*].filename)
}
