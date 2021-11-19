# AzureRM Resource Name

[![MIT License](https://img.shields.io/badge/License-MIT-brightgreen)](LICENSE)
[![Terraform Registry](https://img.shields.io/badge/Terraform-Registry-blue)](https://registry.terraform.io/modules/bellyslap/resource-name/azurerm/latest)

A Terraform module designed to generate one or more names _for Azure resources_. The name quickly identifies the application/workload associated with the resource (`name`), the Azure region where the resource is hosted (`location`), the resource's type (`resource_type`), and its deployment environment (`environment`).

Naming convention: **{application/workload}**-**{Azure region}**-**{resource type}**-**{instance}**-**{deployment-environment}**

This module references the [recommended abbrievations for Azure resource types](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations). (Oct 2021)

Examples:

- A resource group: _example-rg-dev_
- A resource group in one or more regions: _example-centralus-rg-dev_, _example-eastus2-rg-dev_, etc.
- Multiple virtual machines in the `eastus2` region: _example-eastus2-1-vm-dev_, _example-eastus2-2-vm-dev_, etc.

## Requirements

|Name|Version|
|---|---|
|Terraform|>= 0.14

## Argument Reference

- `name` - (Required) Specifies the name of the application, workload, or service that the resource is a part of.

- `environment` - (Optional) Specifies the stage of the development lifecycle for the workload that the resource supports.

- `locations` - (Optional) Specifies one or more Azure region where the resource is deployed.

- `quantity` - (Optional) Specifies the number of resource instances.

- `resource_type` - (Optional) Specifies the type of Azure resource or asset.

- `separator` - (Optional) Specifies the string separating the components of the resource name. Defaults to `-`.

## Attributes Reference

- `locations` - A map of resource names incorporating the resource's location with the location as the key.

- `name` - The resource name for a single instance _without a location_.

- `names` - A list of resource names for one or more instances.

## Example Usage

### Resource Group

```hcl
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

### Resource Groups in Multiple Regions

```hcl
variable "locations" {
  default = ["eastus2", "centralus"]
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

### Multiple Virtual Machines

```hcl
variable "vm_quantity" {
  default = 2
}

module "vm_name" {
  source        = "bellyslap/resource-name/azurerm"
  version       = "0.0.3-beta"
  name          = "example"
  resource_type = "Virtual Machine"
  environment   = "dev"
  locations     = ["eastus2"]
  quantity      = var.vm_quantity
}

resource "azurerm_linux_virtual_machine" "example" {
  count = var.vm_quantity
  name  = module.vm_name.names[count.index]

  ...

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
```
