
# Create a public VNet
resource "azurerm_virtual_network" "teamA-PublicVNet" {
  name                = "${var.name}-PublicVNet"
  resource_group_name = var.rg
  location            = var.location
  address_space       = [var.public_vnet_cidr]
}

# Create public subnet1
resource "azurerm_subnet" "teamA-pub-subnet1" {
  name                = "${var.public-subnet}-1"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.teamA-PublicVNet.name
  address_prefixes     = ["10.30.1.0/24"]
}

# Create public subnet2
resource "azurerm_subnet" "teamA-pub-subnet2" {
  name                = "${var.public-subnet}-2"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.teamA-PublicVNet.name
  address_prefixes     = ["10.30.2.0/24"]
}

# Create public subnet3
resource "azurerm_subnet" "teamA-pub-subnet3" {
  name                = "${var.public-subnet}-3"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.teamA-PublicVNet.name
  address_prefixes     = ["10.30.3.0/24"]
}

#CREATE NSG AND RULES
resource "azurerm_network_security_group" "public-NSG" {
    name = "${var.name}-NSG"
    location = var.location
    resource_group_name = var.rg
}

#Allow HTTP
resource "azurerm_network_security_rule" "allow_http" {
    name = "allow-http"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "*"
    network_security_group_name = azurerm_network_security_group.public-NSG.name
    resource_group_name = var.rg
}

#Allow HTTPS
resource "azurerm_network_security_rule" "allow_https" {
    name = "allow-htps"
    priority = 110
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "443"
    source_address_prefix = "*"
    network_security_group_name = azurerm_network_security_group.public-NSG.name
    resource_group_name = var.rg
}

#Associate NSG with the subnets
resource "azurerm_subnet_network_security_group_association" "public-subnet-1_NSG" {
    subnet_id = azurerm_subnet.teamA-pub-subnet1.id
    network_security_group_id = azurerm_network_security_group.public-NSG.id
}
resource "azurerm_subnet_network_security_group_association" "public-subnet-2_NSG" {
    subnet_id = azurerm_subnet.teamA-pub-subnet2.id
    network_security_group_id = azurerm_network_security_group.public-NSG.id
}
resource "azurerm_subnet_network_security_group_association" "public-subnet-3_NSG" {
    subnet_id = azurerm_subnet.teamA-pub-subnet3.id
    network_security_group_id = azurerm_network_security_group.public-NSG.id
}
