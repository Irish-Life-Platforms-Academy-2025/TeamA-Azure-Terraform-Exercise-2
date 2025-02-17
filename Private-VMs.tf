
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

# Create public subnet3
resource "azurerm_subnet" "teamA-priv-subnet3" {
  name                = "${var.private-subnet}-3"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.teamA-PrivateVNet.name
  address_prefixes     = ["10.30.3.0/24"]
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

# Create private network interface3
resource "azurerm_network_interface" "teamA-nic3" {
  name                = "teamA-priv-nic3"
  resource_group_name = var.rg
  location            = var.location

  ip_configuration {
    name                          = "teamA_nic_config3"
    subnet_id                     = azurerm_subnet.teamA-priv-subnet3.id
    private_ip_address_allocation = "Dynamic"
    
  }
}

# Create virtual machine1
resource "azurerm_linux_virtual_machine" "teamA-vm1" {
  name                = "${var.name}-Private-vm1"
  resource_group_name = var.rg
  location            = var.location
  network_interface_ids = [azurerm_network_interface.teamA-nic1.id]
  size                  = var.vm_size

  os_disk {
    name                 = "myOsDisk1"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  computer_name  = "hostname"
  admin_username = var.username
  admin_password = var.password
  disable_password_authentication = false
}

# Create virtual machine2
resource "azurerm_linux_virtual_machine" "teamA-vm2" {
  name                = "${var.name}-Private-vm2"
  resource_group_name = var.rg
  location            = var.location
  network_interface_ids = [azurerm_network_interface.teamA-nic2.id]
  size                  = var.vm_size

  os_disk {
    name                 = "myOsDisk2"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  computer_name  = "hostname"
  admin_username = var.username
  admin_password = var.password
  disable_password_authentication = false
}

# Create virtual machine3
resource "azurerm_linux_virtual_machine" "teamA-vm3" {
  name                = "${var.name}-Private-vm3"
  resource_group_name = var.rg
  location            = var.location
  network_interface_ids = [azurerm_network_interface.teamA-nic3.id]
  size                  = var.vm_size

  os_disk {
    name                 = "myOsDisk3"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  computer_name  = "hostname"
  admin_username = var.username
  admin_password = var.password
  disable_password_authentication = false
}



