# Create virtual machine1
resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "${var.name}-${var.environment}-Private-vm1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  zone = "1"
  network_interface_ids = [azurerm_network_interface.nic1.id]
  size                  = var.vm_size

  os_disk {
    name                 = "myOsDisk1"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "hostname1"
  admin_username = var.username
  admin_password = var.password
  disable_password_authentication = false
}

# Create virtual machine2
resource "azurerm_linux_virtual_machine" "vm2" {
  name                = "${var.name}-${var.environment}-Private-vm2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  zone = "3"
  network_interface_ids = [azurerm_network_interface.nic2.id]
  size                  = var.vm_size2

  os_disk {
    name                 = "myOsDisk2"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "hostname2"
  admin_username = var.username
  admin_password = var.password
  disable_password_authentication = false
}