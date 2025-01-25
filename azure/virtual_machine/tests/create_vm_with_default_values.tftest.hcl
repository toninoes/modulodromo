variables {
  name                 = "mi-vn-name"
  resource_group_name  = "mi-resource-group-for-vm"
  subnet_name          = "mi-subnet"
  virtual_network_name = "mi-vnet-name"
}

mock_provider "azurerm" {
  mock_data "azurerm_subnet" {
    defaults = {
      id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnetValue"
    }
  }
}

run "create_linux_vm_with_default_values" {
  command = plan

  variables {
    ss_oo = "linux"
  }

  assert {
    condition     = length(azurerm_linux_virtual_machine.this) == 1
    error_message = "The number of Linux VM should be one"
  }

  assert {
    condition     = length(azurerm_windows_virtual_machine.this) == 0
    error_message = "The number of Windows VM should be cero"
  }
}

run "create_windows_vm_with_default_values" {
  command = plan

  variables {
    ss_oo = "windows"
  }

  assert {
    condition     = length(azurerm_windows_virtual_machine.this) == 1
    error_message = "The number of Windows VM should be one"
  }

  assert {
    condition     = length(azurerm_linux_virtual_machine.this) == 0
    error_message = "The number of Linux VM should be cero"
  }
}