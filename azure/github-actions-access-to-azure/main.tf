resource "azuread_application" "this" {
  description      = var.app_description
  display_name     = var.app_display_name
  owners           = [data.azuread_client_config.this.object_id]
  sign_in_audience = var.sign_in_audience

  lifecycle {
    ignore_changes = [owners]
  }
}

resource "azuread_service_principal" "this" {
  client_id   = azuread_application.this.client_id
  description = var.spn_description
  owners      = [data.azuread_client_config.this.object_id]

  lifecycle {
    ignore_changes = [owners]
  }
}

resource "azurerm_role_assignment" "this" {
  principal_id         = azuread_service_principal.this.object_id
  role_definition_name = var.role_definition_name
  scope                = data.azurerm_resource_group.this.id

  lifecycle {
    ignore_changes = [scope]
  }
}

resource "azuread_application_federated_identity_credential" "this" {
  for_each = toset(var.environments)

  application_id = azuread_application.this.id
  audiences      = ["api://AzureADTokenExchange"]
  description    = var.federated_identity_credential_description
  display_name   = "${var.federated_identity_credential_display_name}-${each.key}-Env"
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${var.github_organization}/${var.github_repository}:environment:${each.key}"
}

resource "github_actions_secret" "azure_client_id" {
  repository      = var.github_repository
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = azuread_application.this.client_id

  lifecycle {
    ignore_changes = [plaintext_value]
  }
}

resource "github_actions_secret" "azure_subscription_id" {
  repository      = var.github_repository
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_client_config.this.subscription_id

  lifecycle {
    ignore_changes = [plaintext_value]
  }
}

resource "github_actions_secret" "azure_tenant_id" {
  repository      = var.github_repository
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = data.azuread_client_config.this.tenant_id

  lifecycle {
    ignore_changes = [plaintext_value]
  }
}

resource "github_actions_secret" "extra_secrets" {
  for_each = { for secret in var.github_extra_secrets : secret.name => secret }

  repository      = var.github_repository
  secret_name     = each.key
  plaintext_value = each.value.value

  lifecycle {
    ignore_changes = [plaintext_value]
  }
}
