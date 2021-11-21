provider "azurerm" {
  features {}
}

variable "location" {
  description = "Specifies the Azure region where the resource group is deployed."
  default     = "eastus2"
}

module "rg_name" {
  source        = "bellyslap/resource-name/azurerm"
  version       = "0.0.4-beta"
  name          = "example"
  resource_type = "Resource Group"
  environment   = "dev"
}

resource "azurerm_resource_group" "example" {
  name     = module.rg_name.name
  location = var.location
}

module "rg_name_with_location" {
  source        = "bellyslap/resource-name/azurerm"
  version       = "0.0.4-beta"
  name          = "example"
  location      = var.location
  resource_type = "Resource Group"
  environment   = "dev"
}

resource "azurerm_resource_group" "example_with_location" {
  name     = module.rg_name_with_location.name
  location = var.location
}
