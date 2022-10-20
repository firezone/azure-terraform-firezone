#------------------------ VM Outputs ---------------------------
#---------------------------------------------------------------
output "vm_id" {
  description = "ID of the Firezone virtual machine."
  value       = azurerm_linux_virtual_machine.firezone_vm.id
}

output "vm_identity" {
  description = "Managed Identity of the Firezone virtual machine."
  value       = azurerm_linux_virtual_machine.firezone_vm.identity
}

output "vm_nic_id" {
  description = "ID of the Firezone virtual machine NIC."
  value       = azurerm_network_interface.firezone_vm_nic.id
}

output "vm_private_ip" {
  description = "Private IP Address of the Firezone virtual machine primary NIC."
  value       = azurerm_network_interface.firezone_vm_nic.private_ip_address
}

output "vm_public_ip" {
  description = "Public IP Address of the Firezone virtual machine primary NIC."
  value       = azurerm_public_ip.firezone_vm_pip.ip_address
}

#------------------------ Secret Outputs -----------------------
#---------------------------------------------------------------
output "vm_password" {
  description = "Password for the 'firezone' user account on the Firezone virtual machine."
  value       = random_password.vm_password.result
  sensitive   = true
}

output "firezone_admin_password" {
  description = "Password for the Firezone default admin account."
  value       = random_password.firezone_admin_password.result
  sensitive   = true
}

output "firezone_db_password" {
  description = "Password for the Firezone 'firezone' postgres database 'postgres' user."
  value       = random_password.firezone_db_password.result
  sensitive   = true
}

output "firezone_aad_sp_password" {
  description = "Password for the Firezone Azure AD service principal."
  value       = azuread_service_principal_password.firezonevpn_aad_sp[0].value
  sensitive   = true
}
