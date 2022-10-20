# VM Root Password
resource "random_password" "vm_password" {
  length      = 18
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}
resource "azurerm_key_vault_secret" "vm_password" {
  count        = var.enable_az_keyvault == true ? 1 : 0
  name         = "firezone-vm-password"
  value        = random_password.vm_password.result
  key_vault_id = var.keyvault_id
}

# Firezone default local admin password
resource "random_password" "firezone_admin_password" {
  length      = 18
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}
resource "azurerm_key_vault_secret" "firezone_admin_password" {
  count        = var.enable_az_keyvault == true ? 1 : 0
  name         = "firezone-admin-password"
  value        = random_password.firezone_admin_password.result
  key_vault_id = var.keyvault_id
}

# Firezone postgres user database password
resource "random_password" "firezone_db_password" {
  length      = 18
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}
resource "azurerm_key_vault_secret" "firezone_db_password" {
  count        = var.enable_az_keyvault == true ? 1 : 0
  name         = "firezone-db-password"
  value        = random_password.firezone_db_password.result
  key_vault_id = var.keyvault_id
}

# Firezone VPN AAD Service Principal Password
resource "azurerm_key_vault_secret" "firezonevpn_aad_sp" {
  count        = var.enable_aad_app == true ? 1 : 0
  name         = "firezonevpn-aad-sp-password"
  value        = azuread_service_principal_password.firezonevpn_aad_sp[0].value
  key_vault_id = var.keyvault_id
}
