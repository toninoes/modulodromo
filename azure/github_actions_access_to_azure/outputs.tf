output "AZURE_CLIENT_ID" {
  description = "Create a GitHub secret in your repo named AZURE_CLIENT_ID and store this value. To enhance workflow security in public repositories, use environment secrets instead of repository secrets."
  value       = azuread_application.this.client_id
}

output "AZURE_SUBSCRIPTION_ID" {
  description = "Create a GitHub secret in your repo named AZURE_SUBSCRIPTION_ID and store this value. To enhance workflow security in public repositories, use environment secrets instead of repository secrets."
  value       = data.azurerm_client_config.this.subscription_id
}

output "AZURE_TENANT_ID" {
  description = "Create a GitHub secret in your repo named AZURE_TENANT_ID and store this value. To enhance workflow security in public repositories, use environment secrets instead of repository secrets."
  value       = data.azuread_client_config.this.tenant_id
}
