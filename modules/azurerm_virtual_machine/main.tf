resource "azurerm_linux_virtual_machine" "abhi-vm1" {
  name                = var.vm-name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
     admin_password      = var.admin_password
     disable_password_authentication = false
  network_interface_ids = var.network_interface_ids

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image-publisher
    offer     = var.image-offer
    sku       = var.image-sku
    version   = "latest"
  }
}

