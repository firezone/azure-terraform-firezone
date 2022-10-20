#--------------------- Required Variables ----------------------
#---------------------------------------------------------------

variable "location" {
  description = "Azure region name in standard format to create resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name to be created."
  type        = string
}

variable "domain_name" {
  description = "Root Domain for Firezone VPN VM. (Domain root name only, ex. example.com)"
  type        = string
}

variable "admin_email" {
  description = "Administrator email address."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the Firezone VM network interface."
  type        = string
}

variable "keyvault_id" {
  description = "ID of the Keyvault to store the Firezone secrets."
  type        = string
}

variable "dns_resource_group_name" {
  description = "Resource group name containing the Azure DNS zone."
  type        = string
}

#--------------------- Optional Variables ----------------------
#---------------------------------------------------------------

#---------------------- Feature Flags --------------------------

variable "enable_aad_app" {
  description = "Enable Azure AD App registration for Firezone VPN"
  type        = bool
  default     = false
}

variable "enable_az_keyvault" {
  description = "Enable Azure Keyvault storage of Firezone secrets"
  type        = bool
  default     = true
}

variable "enable_az_dns" {
  description = "Enable Azure DNS registration for Firezone VPN"
  type        = bool
  default     = true
}

#---------------------- General Options ------------------------

variable "resource_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

#---------------------- VM Options -----------------------------

variable "vm_size" {
  description = "VM Size to use for the Firezone VM"
  type        = string
  default     = "Standard_B1ms"
}

#-------------------- Firezone Options -------------------------

variable "hostname" {
  description = "Hostname for Firezone. (name only, not FQDN)"
  type        = string
  default     = "firezone"
}

variable "firezone_ipv4_address" {
  description = "Tunnel-side IPv4 address of Firezone."
  type        = string
  default     = "10.3.2.1"
}

variable "firezone_ipv4_network" {
  description = "Tunnel-side IPv4 network for Firezone to use."
  type        = string
  default     = "10.3.2.0/24"
}

variable "firezone_allowed_ips" {
  description = "Default allowed ip addresses and/or ranges (IPv4 and/or IPv6) used in Firezone client configurations."
  type        = string
  default     = "0.0.0.0, ::/0" # Allow All IPv4 and IPv6
}

variable "firezone_dns" {
  description = "Default DNS servers used in Firezone client configurations."
  type        = string
  default     = "1.1.1.1, 1.0.0.1" # Cloudflare Public DNS
}
