terraform {
  required_version = "~> 1.0"

  # bash
  # # Crear un grupo de recursos:
  # az group create --name terraform-backend-rg --location "West Europe"
  # # Crear una cuenta de almacenamiento:
  # az storage account create --name terraformstatetoninoes --resource-group terraform-backend-rg --location "West Europe" --sku Standard_LRS
  # Crea un contenedor en la cuenta de almacenamiento para almacenar el archivo de estado de Terraform:
  # az storage container create --name terraformstate --account-name terraformstatetoninoes
  backend "azurerm" {
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "terraformstatetoninoes"
    container_name       = "terraformstate"
    key                  = "toninoes/testing-modules/terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}