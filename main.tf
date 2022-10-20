#------------------------- Locals ------------------------------
#---------------------------------------------------------------

# Get AzureRM current config
data "azurerm_client_config" "current" {}

locals {
  fqdn = "${var.hostname}.${var.domain_name}"
}

#------------------------- Resources----------------------------
#---------------------------------------------------------------

# Firezone Resource Group
resource "azurerm_resource_group" "firezone_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.resource_tags
}

# Firezone Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "firezone_vm" {

  name                            = "firezone-vm"
  computer_name                   = local.fqdn
  resource_group_name             = azurerm_resource_group.firezone_rg.name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = "firezone"
  admin_password                  = random_password.vm_password.result
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.firezone_vm_nic.id]
  tags                            = var.resource_tags

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "firezone-vm-osDisk"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-11"
    sku       = "11-gen2"
    version   = "latest"
  }
}

# Firezone Virtual Machine App Disk
resource "azurerm_managed_disk" "vm_app_disk" {
  name                 = "firezone-vm-appDisk"
  location             = var.location
  resource_group_name  = azurerm_resource_group.firezone_rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "5"
  tags                 = var.resource_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm_app_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.vm_app_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.firezone_vm.id
  lun                = "0"
  caching            = "ReadWrite"
}

# Firezone Virtual Machine NIC
resource "azurerm_network_interface" "firezone_vm_nic" {
  name                = "firezone-vm-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.firezone_rg.name

  ip_configuration {
    name                          = "default"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.firezone_vm_pip.id
  }
}

# Public IP Address for Firezone VM
resource "azurerm_public_ip" "firezone_vm_pip" {
  name                = "firezone-vm-pip"
  resource_group_name = azurerm_resource_group.firezone_rg.name
  location            = var.location
  allocation_method   = "Static"
  tags                = var.resource_tags
}

# A record for Firezone VM public IP
resource "azurerm_dns_a_record" "firezone_vm" {
  count               = var.enable_az_dns== true ? 1 : 0
  name                = var.hostname
  zone_name           = var.domain_name
  resource_group_name = var.dns_resource_group_name
  ttl                 = 300
  records             = ["${azurerm_public_ip.firezone_vm_pip.ip_address}"]
}

# Custom Script for Linux VM Extension
resource "azurerm_virtual_machine_extension" "custom_script" {
  name                 = "CustomScriptExtension"
  virtual_machine_id   = azurerm_linux_virtual_machine.firezone_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  protected_settings = <<PROT
    {
      "script": "${base64encode(templatefile("${path.module}/assets/docker-install.sh.tftpl", {
  FQDN                   = "${local.fqdn}",
  ADMIN_EMAIL            = "${var.admin_email}",
  DEFAULT_ADMIN_PASSWORD = "${random_password.firezone_admin_password.result}",
  WIREGUARD_IPV4_ADDRESS = "${var.firezone_ipv4_address}",
  WIREGUARD_IPV4_NETWORK = "${var.firezone_ipv4_network}",
  WIREGUARD_ALLOWED_IPS  = "${var.firezone_allowed_ips}",
  WIREGUARD_DNS          = "${var.firezone_dns}",
DATABASE_PASSWORD = "${random_password.firezone_db_password.result}" }
))}"
    }
PROT

depends_on = [
  azurerm_virtual_machine_data_disk_attachment.vm_app_disk_attach
]
}
