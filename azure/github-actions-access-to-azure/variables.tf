
variable "app_description" {
  default     = ""
  description = "A description of the application, as shown to end users."
  type        = string
}

variable "app_display_name" {
  description = "The display name for the application."
  type        = string
}

variable "environments" {
  default     = ["build", "staging", "production"]
  description = "Possible environments where we can deploy."
  type        = list(string)
}

variable "federated_identity_credential_description" {
  default     = "Deployments for my-repo"
  description = "A description for the federated identity credential."
  type        = string
}

variable "federated_identity_credential_display_name" {
  default     = "GitHub-OIDC"
  description = "A unique display name for the federated identity credential. Changing this forces a new resource to be created."
  type        = string
}

variable "github_organization" {
  default     = "toninoes"
  description = "The GitHub account."
  type        = string
}

variable "github_extra_secrets" {
  description = "Extra GitHub environment secrets."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "github_repository" {
  description = "GitHub repository which contains GitHub Actions workflows to access resources in Azure."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created"
  type        = string
}

variable "role_definition_name" {
  default     = "Reader"
  description = "The name of a built-in Role. Changing this forces a new resource to be created."
  type        = string
}

variable "sign_in_audience" {
  default     = "AzureADMyOrg"
  description = "The Microsoft account types that are supported for the current application. Must be one of AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount or PersonalMicrosoftAccount"
  type        = string

  validation {
    condition     = contains(["AzureADMyOrg", "AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount", "PersonalMicrosoftAccount"], var.sign_in_audience)
    error_message = "Invalid Connection mode. Valid options are Default, InitiatorOnly and ResponderOnly."
  }
}

variable "spn_description" {
  default     = ""
  description = "A description of the service principal provided for internal end-users."
  type        = string
}
