resource "azurerm_network_interface" "linux_vm" {

  count = length(module.vnet[*].vnet_name)

  name                = "${module.vnet[count.index].vnet_name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet[count.index].vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {

  count = length(module.vnet[*].vnet_name)

  name                = "${module.vnet[count.index].vnet_name}-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = data.azurerm_key_vault_secret.keyvault-username.value

  network_interface_ids = [
    azurerm_network_interface.linux_vm[count.index].id,
  ]

  admin_ssh_key {
    username   = data.azurerm_key_vault_secret.keyvault-username.value
    public_key = data.azurerm_ssh_public_key.sshkey.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

    depends_on = [
    azurerm_resource_group.rg,
  ]
}


