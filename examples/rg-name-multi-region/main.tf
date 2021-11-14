provider "azurerm" {
  features {}
}

variable "locations" {
  default = ["eastus2", "centralus"]
}

module "rg_names" {
  source        = "bellyslap/azurerm/resource-name"
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
