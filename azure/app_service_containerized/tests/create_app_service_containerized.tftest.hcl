variables {
  app_name            = "myapp"
  resource_group_name = "rg-your-rg-name"
}

mock_provider "azurerm" {}

run "create_app_service_containerized" {
  command = plan

  # TODO: We can implement some tests here
}
