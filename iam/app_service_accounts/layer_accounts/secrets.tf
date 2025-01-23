module "secrets" {
    source = "../../../security/secret"
    #source = "git::https://github.com/nara-alz-org/modules.git//azure/security/secret"
    
    app_key = var.app_key
    environment = var.environment
    line_of_business_key = var.line_of_business_key
    org_email_domain = var.org_email_domain
    org_key = var.org_key
    team_key = var.team_key
    location = var.location
    key_vault_id = var.key_vault_id

    secret_data = [{
      name = "app-layer-${var.layer_key}-client-id",
      value = azuread_application_registration.layer_deploy_ad_app.client_id
    },
    {
      name = "app-layer--${var.layer_key}-client-secret",
      value = azuread_application_password.layer_deploy_ad_app_pw.value
    }
    ]
}

resource "azurerm_key_vault_access_policy" "regional" {
  key_vault_id = var.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azuread_service_principal.layer_deploy_app_sa.object_id

  secret_permissions      = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Backup",
    "Restore",
    "Purge",
  ]
}
