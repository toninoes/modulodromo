module "my_vnet" {
  source = "./modules/VNet"

  resource_group_name  = "mi-resource-group-for-vnet"
  virtual_network_name = "mi-vnet"

  subnets = {
    subnet1 = {
      name    = "my-subnet1"
      address = ["10.0.1.0/24"]
    }
    subnet2 = {
      name    = "my-subnet2"
      address = ["10.0.2.0/24"]
    }
  }

  tags = var.common_tags
}

module "my_vm" {
  source = "./modules/VM"

  resource_group_name            = "mi-resource-group-for-vm"
  subnet_name                    = "my-subnet1"
  tags                           = var.common_tags
  virtual_network_name           = module.my_vnet.vnet__name
  virtual_network_resource_group = module.my_vnet.vnet_resource_group_name
  vm_name                        = "mi-vm"

  depends_on = [module.my_vnet]
}
