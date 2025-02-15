output "AZURE_CLIENT_ID" {
  description = "The client (application) ID of an App Registration in the tenant."
  value       = azuread_application.this.client_id
}

output "AZURE_SUBSCRIPTION_ID" {
  description = "A unique identifier for your Azure subscription. It's a 32-character alphanumeric string."
  value       = data.azurerm_client_config.this.subscription_id
}

output "AZURE_TENANT_ID" {
  description = "A unique identifier associated with your Azure Active Directory (Azure AD) tenant."
  value       = data.azuread_client_config.this.tenant_id
}
