module "secrets" {
    source = "git::https://github.com/nara-alz-org/modules.git//azure/security/secret"
    
    location = var.location
    key_vault_id = var.key_vault_id

    secret_data = [{
      name = "app-${var.app_name}-client-id",
      value = azuread_application_registration.app_reg.client_id
    },
    {
      name = "app-${var.app_name}-client-secret",
      value = azuread_application_password.ad_app_pw.value
    }
    ]
}

resource "azurerm_key_vault_access_policy" "regional" {
  key_vault_id = var.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azuread_service_principal.app_sa.object_id

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
