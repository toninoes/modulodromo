variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created"
  type        = string
}

variable "peer_name" {
  description = "A name you assigned to the other side of the VPN tunnel."
  type        = string
}

variable "gateway_address" {
  description = "The gateway IP address to connect with. Info provided by the other side of the VPN tunnel."
  type        = string
}

variable "address_space" {
  description = "The list of string CIDRs representing the address spaces the gateway exposes. Info provided by the other side of the VPN tunnel."
  type        = list(string)
}

variable "vnet_gw_conn_name" {
  description = "The name of the connection. Changing the name forces a new resource to be created."
  type        = string
}

variable "virtual_network_gateway_id" {
  description = "The ID of the Virtual Network Gateway in which the connection will be created. Changing this forces a new resource to be created."
  type        = string
}

variable "connection_mode" {
  default     = "Default"
  description = "Connection mode to use. Possible values are Default, InitiatorOnly and ResponderOnly."
  type        = string

  validation {
    condition     = contains(["Default", "InitiatorOnly", "ResponderOnly"], var.connection_mode)
    error_message = "Invalid Connection mode. Valid options are Default, InitiatorOnly and ResponderOnly."
  }
}

variable "connection_protocol" {
  default     = "IKEv2"
  description = "The IKE protocol version to use. Possible values are IKEv1 and IKEv2."
  type        = string

  validation {
    condition     = contains(["IKEv1", "IKEv2"], var.connection_protocol)
    error_message = "Invalid IKE protocol version. Possible values are IKEv1 and IKEv2."
  }
}

variable "shared_key" {
  description = "The shared IPSec key. Should be the same in both sides of the VPN tunnel."
  type        = string
}

variable "dh_group" {
  default     = "DHGroup24"
  description = "The DH group used in IKE phase 1 for initial SA. Valid options are DHGroup1, DHGroup14, DHGroup2, DHGroup2048, DHGroup24, ECP256, ECP384, or None."
  type        = string

  validation {
    condition     = contains(["DHGroup1", "DHGroup14", "DHGroup2", "DHGroup2048", "DHGroup24", "ECP256", "ECP384", "None"], var.dh_group)
    error_message = "Invalid DH group used in IKE phase 1. Valid options are DHGroup1, DHGroup14, DHGroup2, DHGroup2048, DHGroup24, ECP256, ECP384, or None."
  }
}

variable "ike_encryption" {
  default     = "GCMAES256"
  description = "The IKE encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, or GCMAES256."
  type        = string

  validation {
    condition     = contains(["AES128", "AES192", "AES256", "DES", "DES3", "GCMAES128", "GCMAES256"], var.ike_encryption)
    error_message = "Invalid IKE encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, or GCMAES256."
  }
}

variable "ike_integrity" {
  default     = "SHA384"
  description = "The IKE integrity algorithm. Valid options are GCMAES128, GCMAES256, MD5, SHA1, SHA256, or SHA384."
  type        = string

  validation {
    condition     = contains(["GCMAES128", "GCMAES256", "MD5", "SHA1", "SHA256", "SHA384"], var.ike_integrity)
    error_message = "Invalid IKE integrity algorithm. Valid options are GCMAES128, GCMAES256, MD5, SHA1, SHA256, or SHA384."
  }
}

variable "ipsec_encryption" {
  default     = "GCMAES256"
  description = "The IPSec encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256, or None."
  type        = string

  validation {
    condition     = contains(["AES128", "AES192", "AES256", "DES", "DES3", "GCMAES128", "GCMAES192", "GCMAES256", "None"], var.ipsec_encryption)
    error_message = "Invalid IPSec encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256, or None."
  }
}

variable "ipsec_integrity" {
  default     = "GCMAES256"
  description = "The IPSec integrity algorithm. Valid options are GCMAES128, GCMAES192, GCMAES256, MD5, SHA1, or SHA256."
  type        = string

  validation {
    condition     = contains(["GCMAES128", "GCMAES192", "GCMAES256", "MD5", "SHA1", "SHA256"], var.ipsec_integrity)
    error_message = "Invalid IPSec integrity algorithm. Valid options are GCMAES128, GCMAES192, GCMAES256, MD5, SHA1, or SHA256."
  }
}

variable "pfs_group" {
  default     = "None"
  description = "The DH group used in IKE phase 2 for new child SA. Valid options are ECP256, ECP384, PFS1, PFS14, PFS2, PFS2048, PFS24, PFSMM, or None."
  type        = string

  validation {
    condition     = contains(["ECP256", "ECP384", "PFS1", "PFS14", "PFS2", "PFS2048", "PFS24", "PFSMM", "None"], var.pfs_group)
    error_message = "Invalid DH group used in IKE phase 2. Valid options are ECP256, ECP384, PFS1, PFS14, PFS2, PFS2048, PFS24, PFSMM, or None."
  }
}

variable "sa_datasize" {
  default     = 102400000
  description = "The IPSec SA payload size in KB. Must be at least 1024 KB. Defaults to 102400000 KB."
  type        = number

  validation {
    condition     = var.sa_datasize >= 1024
    error_message = "Invalid value for IPSec SA payload. Must be at least 1024 KB."
  }
}

variable "sa_lifetime" {
  default     = 27000
  description = "The IPSec SA lifetime in seconds. Must be at least 300 seconds. Defaults to 27000 seconds."
  type        = number

  validation {
    condition     = var.sa_lifetime >= 300
    error_message = "Invalid value for IPSec SA payload. Must be at least 300 seconds."
  }
}
