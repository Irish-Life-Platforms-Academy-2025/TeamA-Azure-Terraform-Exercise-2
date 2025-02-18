# Create virtual machine1
resource "azurerm_linux_virtual_machine" "teamA-vm1" {
  name                = "${var.name}-Private-vm1"
  resource_group_name = var.rg
  location            = var.location
  zone = "1"
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
  zone = "2"
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