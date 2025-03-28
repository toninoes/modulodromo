variable "admin_username" {
  default     = "adminuser"
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "allow_extension_operations" {
  description = "Should Extension Operations be allowed on this Virtual Machine?"
  default     = false
  type        = bool
}

variable "enable_public_ip" {
  default     = true
  description = "Enable public IP to vitual machine"
  type        = bool
}

variable "name" {
  description = "Name to assign to VM"
  type        = string
}

variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created"
  type        = string
}

variable "size" {
  default     = "Standard_B2s"
  description = "The SKU which should be used for this Virtual Machine"
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

variable "windows_admin_pass" {
  default     = "P@$$w0rd1234!"
  description = "The Password which should be used for the local-administrator on this Virtual Machine for Windows. Changing this forces a new resource to be created."
  type        = string
}

variable "ssh_key_pairs_name" {
  default     = "adminuser"
  description = "Name used to create SSH key pairs."
  type        = string
}
