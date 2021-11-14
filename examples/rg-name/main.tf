provider "azurerm" {
  features {}
}

module "rg_name" {
  source        = "bellyslap/azurerm/resource-name"
  name          = "example"
  resource_type = "Resource Group"
  environment   = "dev"
}

resource "azurerm_resource_group" "example" {
  name     = module.rg_name.name
  location = "eastus2"
}
