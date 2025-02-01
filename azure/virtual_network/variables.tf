variable "address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network. You can supply more than one address space."
}

variable "location" {
  default     = "West Europe"
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created"
  type        = string
}

variable "subnets" {
  description = "List of subnets with their corresponding names and address prefixes"
  type = list(object({
    name    = string
    address = list(string)
  }))
  default = []
}

variable "subnet_addresses_for_bastion" {
  default     = []
  description = "List of addresses for bastion."
  type        = list(string)

  validation {
    condition = length(var.subnet_addresses_for_bastion) == 0 || alltrue([
      for cidr in var.subnet_addresses_for_bastion : can(cidrnetmask(cidr)) && tonumber(split("/", cidr)[1]) <= 26
    ])
    error_message = "Each subnet address of 'subnet_address_for_bastion' should be a valid CIDR with a mask with at least /26."
  }
}

variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "virtual_network_name" {
  description = "The name of the virtual network. Changing this forces a new resource to be created."
  type        = string
}
