provider "azurerm" {
  features {}
}

variable "locations" {
  description = "Specifies the Azure regions."
  default     = ["eastus2", "centralus"]
}

module "rg_names" {
  source        = "bellyslap/resource-name/azurerm"
  version       = "0.0.4-beta"
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
