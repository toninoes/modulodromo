# LINUX MACHINE
resource "azurerm_linux_virtual_machine" "this" {
  count = var.ss_oo == "linux" ? 1 : 0

  admin_username      = var.admin_username
  location            = data.azurerm_resource_group.this.location
  name                = var.name
  resource_group_name = var.resource_group_name
  size                = var.size

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.this[0].public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags
}

resource "tls_private_key" "this" {
  count = var.ss_oo == "linux" ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "pem" {
  count = var.ss_oo == "linux" ? 1 : 0

  filename        = "${var.ssh_key_pairs_name}.pem"
  content         = tls_private_key.this[0].private_key_pem
  file_permission = "0400"
}

resource "local_file" "pub" {
  count = var.ss_oo == "linux" ? 1 : 0

  filename        = "${var.ssh_key_pairs_name}.pub"
  content         = tls_private_key.this[0].public_key_openssh
  file_permission = "0400"
}

# WINDOWS MACHINE
resource "azurerm_windows_virtual_machine" "this" {
  count = var.ss_oo == "windows" ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.this.location
  size                = var.size
  admin_username      = "adminuser"
  admin_password      = var.windows_admin_pass

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = var.tags
}

# NIC, PUBLIC-IP & NSG
resource "azurerm_public_ip" "this" {
  count = var.enable_public_ip ? 1 : 0

  name                = "${var.name}-public-ip"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "this" {
  name                = "${var.name}-nic"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.name}-ip-configuration"
    subnet_id                     = data.azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.this[0].id : null
  }

  tags = var.tags

  depends_on = [azurerm_public_ip.this]
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.name}-nsg"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "this" {
  count = var.enable_public_ip ? 1 : 0

  name                        = "AllowExternalConnectionFromSpecificIP"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = var.ss_oo == "linux" ? "22" : "3389"
  source_address_prefix       = local.my_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id

  depends_on = [azurerm_public_ip.this]
}
