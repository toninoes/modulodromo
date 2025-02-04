data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
}

data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}

data "azurerm_public_ip" "this" {
  name                = one(azurerm_public_ip.this[*].name)
  resource_group_name = var.resource_group_name
}