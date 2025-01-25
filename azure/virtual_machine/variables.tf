variable "application" {
  description = "Application to assign to VM"
  type        = string
}

variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "location" {
  default     = "West Europe"
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created"
  type        = string
}

variable "ss_oo" {
  default     = "linux"
  description = "Operating System. Linux or windows"
  type        = string

  validation {
    condition     = contains(["linux", "windows"], var.ss_oo)
    error_message = "Invalid environment. You can only can select between linux or windows"
  }
}

variable "subnet_name" {
  description = "The name of the subnet where to deploy the VM."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network where to deploy the VM."
  type        = string
}

variable "virtual_network_resource_group" {
  description = "The name of the resource group for virtual network where to deploy virtual machine."
  type        = string
}

variable "admin_username" {
  default     = "adminuser"
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "public_key_location" {
  description = "The Public Key which should be used for authentication, which needs to be in ssh-rsa format with at least 2048-bit or in ssh-ed25519 format. Changing this forces a new resource to be created."
  type        = string
}

variable "windows_admin_pass" {
  default     = "P@$$w0rd1234!"
  description = "The Password which should be used for the local-administrator on this Virtual Machine for Windows. Changing this forces a new resource to be created."
  type        = string
}

variable "enable_public_ip" {
  default     = false
  description = "Enable public IP to vitual machine"
  type        = bool
}

variable "mi_ip" {
  description = "IP to Allow connection from"
  type        = string
}