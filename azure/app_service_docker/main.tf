resource "azurerm_container_registry" "this" {
  admin_enabled       = true
  location            = data.azurerm_resource_group.this.location
  name                = var.app_name
  resource_group_name = var.resource_group_name
  sku                 = var.acr_sku

  tags = var.tags
}

resource "azurerm_service_plan" "this" {
  location            = data.azurerm_resource_group.this.location
  name                = "${var.app_name}-sp"
  os_type             = "Linux"
  resource_group_name = var.resource_group_name
  sku_name            = var.service_plan_sku_name

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  https_only          = true
  location            = azurerm_service_plan.this.location
  name                = "${var.app_name}-app"
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on                               = true
    container_registry_use_managed_identity = true

    application_stack {
      docker_image_name        = "${var.app_name}:latest"
      docker_registry_url      = "https://${azurerm_container_registry.this.login_server}"
      docker_registry_username = azurerm_container_registry.this.admin_username
      docker_registry_password = azurerm_container_registry.this.admin_password
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "this" {
  principal_id         = azurerm_linux_web_app.this.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.this.id
}
