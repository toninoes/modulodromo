variable "backend_address_pools" {
  description = "List of backend address pools, each containing a name, FQDNs, and/or IP addresses."

  type = list(object({
    name         = string
    fqdns        = optional(list(string), [])
    ip_addresses = optional(list(string), [])
  }))
}

variable "backend_http_settings_list" {
  description = "A list of backend HTTP settings collections, each containing various HTTP settings configurations."

  type = list(object({
    name                           = string
    cookie_based_affinity          = string
    affinity_cookie_name           = optional(string, null)
    path                           = optional(string, null)
    port                           = number
    probe_name                     = optional(string, null)
    protocol                       = string
    request_timeout                = optional(number, 30)
    host_name                      = optional(string, null)
    pick_host_name_from_backend    = optional(bool, false)
    trusted_root_certificate_names = optional(list(string), [])
  }))
}

variable "create_public_ip" {
  description = "Optional public IP to auto create public id"
  type        = bool
  default     = true
}

variable "extra_frontend_ip_configurations" {
  description = "List of frontend IP configurations, each containing details for the Application Gateway."

  type = list(object({
    name                            = string
    subnet_id                       = optional(string, null)
    private_ip_address              = optional(string, null)
    private_ip_address_allocation   = optional(string, "Dynamic")
    private_link_configuration_name = optional(string, null)
  }))

  default = []
}

variable "frontend_ip_configuration_public_name" {
  description = "(Optional) The name of the public Frontend IP Configuration.  If not supplied will be inferred from the resource name."
  type        = string
  default     = null
}

variable "frontend_ports" {
  description = "List of frontend ports."

  type = list(object({
    name = string
    port = number
  }))
}

variable "gateway_ip_configurations" {
  description = "List of Gateway IP configurations"

  type = list(object({
    name      = string
    subnet_id = string
  }))
}

variable "http_listeners" {
  description = "A list of HTTP listeners for the Application Gateway, specifying their configurations."

  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    host_names                     = optional(list(string), [])
    require_sni                    = optional(bool, false)
    ssl_certificate_name           = optional(string, null)
    firewall_policy_id             = optional(string, null)
    ssl_profile_name               = optional(string, null)
  }))
}

variable "name" {
  description = "Name for Application Gateway."
  type        = string
}

variable "request_routing_rules" {
  description = "A list of request routing rules, each specifying the configuration for routing requests in the Application Gateway."

  type = list(object({
    name                        = string
    rule_type                   = string
    http_listener_name          = string
    backend_address_pool_name   = optional(string, null)
    backend_http_settings_name  = optional(string, null)
    redirect_configuration_name = optional(string, null)
    rewrite_rule_set_name       = optional(string, null)
    url_path_map_name           = optional(string, null)
    priority                    = optional(number, null)
  }))
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created"
  type        = string
}

variable "sku" {
  description = "Defines the SKU (Stock Keeping Unit) configuration for the Azure Application Gateway. It includes the name, tier, and capacity of the SKU."

  type = object({
    name     = string
    tier     = string
    capacity = number
  })

  default = {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  validation {
    condition = (
      contains(["Basic", "Standard_v2", "WAF_v2"], var.sku.name) &&
      contains(["Basic", "Standard_v2", "WAF_v2"], var.sku.tier) &&
      (
        (var.sku.name == "Basic" && var.sku.capacity >= 1 && var.sku.capacity <= 2) ||
        (contains(["Standard_v2", "WAF_v2"], var.sku.name) && var.sku.capacity >= 1 && var.sku.capacity <= 125) ||
        (var.sku.name == "V1" && var.sku.capacity >= 1 && var.sku.capacity <= 32)
      )
    )
    error_message = "The 'sku' object must adhere to valid values. Ensure 'name' and 'tier' are among Basic, Standard_v2, or WAF_v2. Also, check that 'capacity' meets the specified limits."
  }
}

variable "ssl_policy_name" {
  description = "SSL policy name for the Application Gateway"
  type        = string
  default     = "AppGwSslPolicy20220101S"

  validation {
    condition     = contains(["AppGwSslPolicy20170401S", "AppGwSslPolicy20220101", "AppGwSslPolicy20220101S"], var.ssl_policy_name)
    error_message = "The ssl_policy_name must be one of the following: AppGwSslPolicy20170401S, AppGwSslPolicy20220101, AppGwSslPolicy20220101S."
  }
}

variable "tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "waf_configuration" {
  description = "Application Gateway WAF configuration"

  type = object({
    enabled          = optional(bool, true)
    firewall_mode    = optional(string, "Prevention")
    rule_set_type    = optional(string, "OWASP")
    rule_set_version = optional(string, "3.2")
  })

  default = null
}

variable "zones" {
  description = "(Optional) Specifies a list of Availability Zones in which this Application Gateway should be located. Changing this forces a new Application Gateway to be created."
  type        = set(string)
  default     = ["1", "2", "3"]
}
