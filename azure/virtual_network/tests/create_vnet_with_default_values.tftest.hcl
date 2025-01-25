variables {
  address_space        = ["10.0.0.0/16"]
  resource_group_name  = "mi-resource-group-for-vnet"
  virtual_network_name = "mi-vnet"
}

mock_provider "azurerm" {}

provider "azurerm" {
  alias = "mocked"
}

run "create_vnet_with_default_values" {
  command = plan

  assert {
    condition     = data.azurerm_resource_group.this.name == var.resource_group_name
    error_message = "The Resource Group name should be ${var.resource_group_name}"
  }

  assert {
    condition     = azurerm_virtual_network.this.location == data.azurerm_resource_group.this.location
    error_message = "The Virtual Network location should be the same as resource group"
  }

  assert {
    condition     = azurerm_virtual_network.this.name == var.virtual_network_name
    error_message = "The Virtual Network name should be ${var.virtual_network_name}"
  }
}
