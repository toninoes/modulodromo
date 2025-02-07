resource "azuread_application" "this" {
  description      = var.app_description
  display_name     = var.app_display_name
  owners           = [data.azuread_client_config.this.object_id]
  sign_in_audience = var.sign_in_audience
}

resource "azuread_service_principal" "this" {
  client_id   = azuread_application.this.client_id
  description = var.spn_description
  owners      = [data.azuread_client_config.this.object_id]
}

resource "azurerm_role_assignment" "this" {
  principal_id         = azuread_service_principal.this.object_id
  role_definition_name = var.role_definition_name
  scope                = data.azurerm_resource_group.this.id
}

resource "azuread_application_federated_identity_credential" "this" {
  application_id = azuread_application.this.id
  audiences      = ["api://AzureADTokenExchange"]
  description    = var.federated_identity_credential_description
  display_name   = var.federated_identity_credential_display_name
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${var.github_organization}/${var.github_repository}:ref:refs/heads/main"
}
