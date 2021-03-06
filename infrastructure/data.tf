data "azurerm_key_vault_secret" "keyvault-username" {
  name                = "adminusername"
  key_vault_id        = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/CloudShell/providers/Microsoft.KeyVault/vaults/cs-keystore"
}

data "azurerm_key_vault_secret" "keyvault-password" {
  name                = "adminpassword"
  key_vault_id        = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/CloudShell/providers/Microsoft.KeyVault/vaults/cs-keystore"
}

data "azurerm_ssh_public_key" "sshkey" {
  name                = "desktop"
  resource_group_name = "CloudShell"
}

data "azurerm_subscription" "current" {
}