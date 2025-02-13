
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "team-A-vnet" {
  name                = "${var.name}-vnet"
  resource_group_name = var.rg
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

# Create subnet1
resource "azurerm_subnet" "teamA-subnet" {
  name                = "${var.subnet}-1"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.team-A-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create subnet2
resource "azurerm_subnet" "teamA-subnet2" {
  name                = "${var.subnet}-2"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.team-A-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create subnet3
resource "azurerm_subnet" "teamA-subnet3" {
  name                = "${var.subnet}-3"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.team-A-vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}
