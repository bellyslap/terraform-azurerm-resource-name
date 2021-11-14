provider "azurerm" {
  features {}
}

variable "application" {
  default = "example"
}

variable "environment" {
  default = "dev"
}

variable "location" {
  default = "eastus2"
}

variable "vm_quantity" {
  default = 2
}

module "rg_name" {
  source        = "bellyslap/azurerm/resource-name"
  name          = var.application
  resource_type = "Resource Group"
  environment   = var.environment
  locations     = [var.location]
}

resource "azurerm_resource_group" "example" {
  name     = module.rg_name.locations[var.location]
  location = var.location
}

module "vnet_name" {
  source        = "bellyslap/azurerm/resource-name"
  name          = var.application
  resource_type = "Virtual Network"
  environment   = var.environment
  locations     = [var.location]
}

resource "azurerm_virtual_network" "example" {
  name                = module.vnet_name.locations[var.location]
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

module "snet_name" {
  source        = "bellyslap/azurerm/resource-name"
  name          = "internal"
  resource_type = "Subnet"
}

resource "azurerm_subnet" "example" {
  name                 = module.snet_name.name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

module "nic_name" {
  source        = "bellyslap/azurerm/resource-name"
  name          = var.application
  resource_type = "Network Interface"
  environment   = var.environment
  locations     = [var.location]
  quantity      = var.vm_quantity
}

resource "azurerm_network_interface" "example" {
  count               = var.vm_quantity
  name                = module.nic_name.names[count.index]
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

module "vm_name" {
  source        = "bellyslap/azurerm/resource-name"
  name          = var.application
  resource_type = "Virtual Machine"
  environment   = var.environment
  locations     = [var.location]
  quantity      = var.vm_quantity
}

resource "azurerm_linux_virtual_machine" "example" {
  count               = var.vm_quantity
  name                = module.vm_name.names[count.index]
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"

  admin_username = "adminuser"
  admin_password = "P@$$w0rd1234!"

  network_interface_ids = [
    azurerm_network_interface.example[count.index].id,
  ]

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
