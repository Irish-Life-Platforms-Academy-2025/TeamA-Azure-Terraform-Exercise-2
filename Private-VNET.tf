# Create a Private VNet
resource "azurerm_virtual_network" "teamA-PrivateVNet" {
  name                = "${var.name}-PrivateVNet"
  resource_group_name = var.rg
  location            = var.location
  address_space       = [var.Private_vnet_cidr]
}

# Create private subnet1
resource "azurerm_subnet" "teamA-priv-subnet1" {
  name                = "${var.private-subnet}-1"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.teamA-PrivateVNet.name
  address_prefixes     = ["10.30.1.0/24"]
}

# Create public subnet2
resource "azurerm_subnet" "teamA-priv-subnet2" {
  name                = "${var.private-subnet}-2"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.teamA-PrivateVNet.name
  address_prefixes     = ["10.30.2.0/24"]
}


# Create private network interface1
resource "azurerm_network_interface" "teamA-nic1" {
  name                = "teamA-priv-nic1"
  resource_group_name = var.rg
  location            = var.location

  ip_configuration {
    name                          = "teamA_nic_config1"
    subnet_id                     = azurerm_subnet.teamA-priv-subnet1.id
    private_ip_address_allocation = "Dynamic"
    
  }
}

# Create private network interface2
resource "azurerm_network_interface" "teamA-nic2" {
  name                = "teamA-priv-nic2"
  resource_group_name = var.rg
  location            = var.location

  ip_configuration {
    name                          = "teamA_nic_config2"
    subnet_id                     = azurerm_subnet.teamA-priv-subnet2.id
    private_ip_address_allocation = "Dynamic"
    
  }
}