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

variable "vm_name" {
  description = "The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "admin_pass" {
  default     = "P@$$w0rd1234!"
  description = "The Password which should be used for the local-administrator on this Virtual Machine for Windows. Changing this forces a new resource to be created."
  type        = string
}