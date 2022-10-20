<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.27.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =3.27.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.firezonevpn_aad_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.firezonevpn_aad_sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.firezonevpn_aad_sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_dns_a_record.firezone_vm](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/dns_a_record) | resource |
| [azurerm_key_vault_secret.firezone_admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.firezone_db_password](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.firezonevpn_aad_sp](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.vm_password](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine.firezone_vm](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.vm_app_disk](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.firezone_vm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/network_interface) | resource |
| [azurerm_public_ip.firezone_vm_pip](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.firezone_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/resource_group) | resource |
| [azurerm_virtual_machine_data_disk_attachment.vm_app_disk_attach](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.custom_script](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/resources/virtual_machine_extension) | resource |
| [random_password.firezone_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.firezone_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.vm_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_uuid.firezonevpn_aad_app](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.27.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_email"></a> [admin\_email](#input\_admin\_email) | Administrator email address. | `string` | n/a | yes |
| <a name="input_dns_resource_group_name"></a> [dns\_resource\_group\_name](#input\_dns\_resource\_group\_name) | Resource group name containing the Azure DNS zone. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Root Domain for Firezone VPN VM. (Domain root name only, ex. example.com) | `string` | n/a | yes |
| <a name="input_enable_aad_app"></a> [enable\_aad\_app](#input\_enable\_aad\_app) | Enable Azure AD App registration for Firezone VPN | `bool` | `false` | no |
| <a name="input_enable_az_dns"></a> [enable\_az\_dns](#input\_enable\_az\_dns) | Enable Azure DNS registration for Firezone VPN | `bool` | `true` | no |
| <a name="input_enable_az_keyvault"></a> [enable\_az\_keyvault](#input\_enable\_az\_keyvault) | Enable Azure Keyvault storage of Firezone secrets | `bool` | `true` | no |
| <a name="input_firezone_allowed_ips"></a> [firezone\_allowed\_ips](#input\_firezone\_allowed\_ips) | Default allowed ip addresses and/or ranges (IPv4 and/or IPv6) used in Firezone client configurations. | `string` | `"0.0.0.0, ::/0"` | no |
| <a name="input_firezone_dns"></a> [firezone\_dns](#input\_firezone\_dns) | Default DNS servers used in Firezone client configurations. | `string` | `"1.1.1.1, 1.0.0.1"` | no |
| <a name="input_firezone_ipv4_address"></a> [firezone\_ipv4\_address](#input\_firezone\_ipv4\_address) | Tunnel-side IPv4 address of Firezone. | `string` | `"10.3.2.1"` | no |
| <a name="input_firezone_ipv4_network"></a> [firezone\_ipv4\_network](#input\_firezone\_ipv4\_network) | Tunnel-side IPv4 network for Firezone to use. | `string` | `"10.3.2.0/24"` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname for Firezone. (name only, not FQDN) | `string` | `"firezone"` | no |
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | ID of the Keyvault to store the Firezone secrets. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region name in standard format to create resources. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name to be created. | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet for the Firezone VM network interface. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | VM Size to use for the Firezone VM | `string` | `"Standard_B1ms"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firezone_admin_password"></a> [firezone\_admin\_password](#output\_firezone\_admin\_password) | Password for the Firezone default admin account. |
| <a name="output_firezone_db_password"></a> [firezone\_db\_password](#output\_firezone\_db\_password) | Password for the Firezone 'firezone' postgres database 'postgres' user. |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | ID of the Firezone virtual machine. |
| <a name="output_vm_identity"></a> [vm\_identity](#output\_vm\_identity) | Managed Identity of the Firezone virtual machine. |
| <a name="output_vm_nic_id"></a> [vm\_nic\_id](#output\_vm\_nic\_id) | ID of the Firezone virtual machine NIC. |
| <a name="output_vm_password"></a> [vm\_password](#output\_vm\_password) | Password for the 'firezone' user account on the Firezone virtual machine. |
| <a name="output_vm_private_ip"></a> [vm\_private\_ip](#output\_vm\_private\_ip) | Private IP Address of the Firezone virtual machine primary NIC. |
| <a name="output_vm_public_ip"></a> [vm\_public\_ip](#output\_vm\_public\_ip) | Public IP Address of the Firezone virtual machine primary NIC. |
<!-- END_TF_DOCS -->