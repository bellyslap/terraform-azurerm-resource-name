# Example: Resource Group Name

This example creates the name for a resource group containing resources associated with an **_example_** application for the **_dev_** environment.

```hcl
provider "azurerm" {
  features {}
}

variable "location" {
  default = "eastus2"
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
```
