output "container_registry_login_server" {
  description = "The URL used to log into the container registry."
  value       = azurerm_container_registry.this.login_server
}

output "container_registry_admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.this.admin_username
}

output "container_registry_admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.this.admin_password
}

output "web_app_name" {
  description = "Web App name."
  value       = azurerm_linux_web_app.this.name
}

output "container_registry_name" {
  description = "Container registry name."
  value       = azurerm_container_registry.this.name
}

output "webapp_url" {
  description = "The default hostname of the Linux Web App."
  value = azurerm_linux_web_app.this.default_hostname
}

output "webapp_slot_url" {
  description = "The default hostname of the Linux Web App Slot."
  value = azurerm_linux_web_app_slot.this.default_hostname
}
