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
