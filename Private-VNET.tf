# Create a Private VNet
resource "azurerm_virtual_network" "PrivateVNet" {
  name                = "${var.name}-${var.environment}-PrivateVNet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.Private_vnet_cidr]
}

# Create private subnet1
resource "azurerm_subnet" "priv-subnet1" {
  name = "${var.name}-${var.environment}-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.PrivateVNet.name
  address_prefixes     = ["10.30.1.0/24"]
}

# Create public subnet2
resource "azurerm_subnet" "priv-subnet2" {
  name = "${var.name}-${var.environment}-subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.PrivateVNet.name
  address_prefixes     = ["10.30.2.0/24"]
}


# Create private network interface1
resource "azurerm_network_interface" "nic1" {
  name = "${var.name}-${var.environment}-nic1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name = "${var.name}-${var.environment}-nic1-config"
    subnet_id                     = azurerm_subnet.priv-subnet1.id
    private_ip_address_allocation = "Dynamic"
    
  }
}

# Create private network interface2
resource "azurerm_network_interface" "nic2" {
  name = "${var.name}-${var.environment}-nic2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name = "${var.name}-${var.environment}-nic1-config"
    subnet_id                     = azurerm_subnet.priv-subnet2.id
    private_ip_address_allocation = "Dynamic"
    
  }
}