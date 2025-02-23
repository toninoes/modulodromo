variable "acr_sku" {
  default     = "Standard"
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium"
  type        = string

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "Invalid ACR SKU. Valid options are Basic, Standard and Premium."
  }
}

variable "app_name" {
  description = "Name of the application."
  type        = string
}

variable "service_plan_sku_name" {
  default     = "S1"
  description = "The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3 and Y1."
  type        = string

  validation {
    condition     = contains(["B1", "B2", "B3", "D1", "F1", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "I4v2", "I5v2", "I6v2", "P1v2", "P2v2", "P3v2", "P0v3", "P1v3", "P2v3", "P3v3", "P1mv3", "P2mv3", "P3mv3", "P4mv3", "P5mv3", "S1", "S2", "S3", "SHARED", "EP1", "EP2", "EP3", "FC1", "WS1", "WS2", "WS3", "Y1"], var.service_plan_sku_name)
    error_message = "Invalid Service Plan SKU name. Valid options are B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3 and Y1."
  }
}

variable "tags" {
  default     = {}
  description = "Common tags to be applied to all resources"
  type        = map(string)
}

variable "minimum_tls_version" {
  default     = "1.2"
  description = "The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, 1.2 and 1.3"
  type        = string

  validation {
    condition     = contains(["1.0", "1.1", "1.2", "1.3"], var.minimum_tls_version)
    error_message = "Invalid minimum version of TLS. Valid options are 1.0, 1.1, 1.2 and 1.3"
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created"
  type        = string
}

variable "web_app_slot_name" {
  default     = "staging"
  description = "The name which should be used for this Linux Web App Slot. Changing this forces a new Linux Web App Slot to be created."
  type        = string
}
