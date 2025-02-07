variables {
  app_display_name    = "my-app-name"
  github_repository   = "my-repo"
  resource_group_name = "mi-resource-group-for-gha-access-to-azure"
}

mock_provider "azurerm" {
  mock_data "azurerm_resource_group" {
    defaults = {
      id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group"
    }
  }
}

provider "azuread" {
  alias = "mocked"
}

run "create_github_actions_access_to_azure" {
  command = plan

  # TODO: We can implement some tests here
}
