output "Linux_VMs" {
    value = azurerm_linux_virtual_machine.linux_vm.*.id
}

output "resource_group_name" {
    value = var.resource_group_name
}