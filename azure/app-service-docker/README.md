# Containerized web app with Azure App Service

Creates a containerized App Service

## Usage

```hcl
module "my_app" {
  source = "git::git@github.com:toninoes/modulodromo.git//azure/app-service-docker"

  app_name            = "myapp"
  resource_group_name = "rg-your-rg-name"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | 4.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_linux_web_app_slot.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app_slot) | resource |
| [azurerm_role_assignment.web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.web_app_slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acr\_sku | The SKU name of the container registry. Possible values are Basic, Standard and Premium | `string` | `"Standard"` | no |
| app\_name | Name of the application. | `string` | n/a | yes |
| minimum\_tls\_version | The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, 1.2 and 1.3 | `string` | `"1.2"` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual machine. Changing this forces a new resource to be created | `string` | n/a | yes |
| service\_plan\_sku\_name | The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3 and Y1. | `string` | `"S1"` | no |
| tags | Common tags to be applied to all resources | `map(string)` | `{}` | no |
| web\_app\_slot\_name | The name which should be used for this Linux Web App Slot. Changing this forces a new Linux Web App Slot to be created. | `string` | `"staging"` | no |

## Outputs

| Name | Description |
|------|-------------|
| container\_registry\_admin\_password | The Password associated with the Container Registry Admin account - if the admin account is enabled. |
| container\_registry\_admin\_username | The Username associated with the Container Registry Admin account - if the admin account is enabled. |
| container\_registry\_login\_server | The URL used to log into the container registry. |
| container\_registry\_name | Container registry name. |
| web\_app\_name | Web App name. |
| webapp\_slot\_url | The default hostname of the Linux Web App Slot. |
| webapp\_url | The default hostname of the Linux Web App. |
