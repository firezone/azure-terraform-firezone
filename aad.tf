# Firezone VPN AAD Enterprise Application
resource "random_uuid" "firezonevpn_aad_app" {
  count = var.enable_aad_app == true ? 1 : 0
}

resource "azuread_application" "firezonevpn_aad_app" {
  count           = var.enable_aad_app == true ? 1 : 0
  display_name    = "Firezone VPN"
  identifier_uris = ["https://${local.fqdn}"]
  logo_image      = filebase64("${path.module}/assets/firezonevpn-logo.png")


  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access Firezone VPN on behalf of the signed-in user."
      admin_consent_display_name = "Access Firezone VPN"
      enabled                    = true
      id                         = random_uuid.firezonevpn_aad_app[0].result
      type                       = "User"
      user_consent_description   = "Allow the application to access Firezone VPN on your behalf."
      user_consent_display_name  = "Access Firezone VPN"
      value                      = "user_impersonation"
    }
  }
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
      type = "Role"
    }
  }
  web {
    homepage_url  = "https://${local.fqdn}/auth/oidc/azure"
    redirect_uris = ["https://${local.fqdn}/auth/oidc/azure/callback/"]

    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }
  feature_tags {
    hide = false
  }
}

# Firezone VPN AAD Service Principal
resource "azuread_service_principal" "firezonevpn_aad_sp" {
  count                         = var.enable_aad_app == true ? 1 : 0
  application_id                = azuread_application.firezonevpn_aad_app[0].application_id
  use_existing                  = true
  preferred_single_sign_on_mode = "oidc"
  app_role_assignment_required  = false
  login_url                     = "https://${local.fqdn}/auth/oidc/azure"
  notification_email_addresses  = ["${var.admin_email}"]

  feature_tags {
    gallery    = true
    enterprise = true
  }
}

resource "azuread_service_principal_password" "firezonevpn_aad_sp" {
  count                = var.enable_aad_app == true ? 1 : 0
  service_principal_id = azuread_service_principal.firezonevpn_aad_sp[0].id
}
