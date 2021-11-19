# Example: Resource Group Name (Multi Region)

This example creates the names for resource groups containing resources associated with an **_example_** application deployed to **_eastus2_** and **_centralus_** regions for the **_dev_** environment.

```hcl
provider "azurerm" {
  features {}
}

module "rg_names" {
  source        = "bellyslap/resource-name/azurerm"
  version       = "0.0.3-beta"
  name          = "example"
  resource_type = "Resource Group"
  environment   = "dev"
  locations     = var.locations
}

resource "azurerm_resource_group" "example" {
  for_each = toset(var.locations)
  name     = module.rg_names.locations[each.key]
  location = each.key
}
```
