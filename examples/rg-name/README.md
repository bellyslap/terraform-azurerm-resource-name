# Example: Resource Group Name

This example creates the name for a resource group containing resources associated with an **_example_** application for the **_dev_** environment.

```hcl
provider "azurerm" {
  features {}
}

module "rg_name" {
  source        = "bellyslap/resource-name/azurerm"
  version       = "0.0.3-beta"
  name          = "example"
  resource_type = "Resource Group"
  environment   = "dev"
}

resource "azurerm_resource_group" "example" {
  name     = module.rg_name.name
  location = "eastus2"
}
```
