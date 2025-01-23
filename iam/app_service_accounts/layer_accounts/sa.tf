module "naming_conv" {
  source = "../../../foundation/naming_conv"
  #source = "git::https://github.com/nara-alz-org/modules.git//azure/foundation/naming_conv"
  app_key = var.app_key
  environment = var.environment
  line_of_business_key = var.line_of_business_key
  org_email_domain = var.org_email_domain
  org_key = var.org_key
  team_key = var.team_key
  location_short = var.location_short
  db_type = ""
  layer_key = var.layer_key
}

#sa
resource "azuread_application_registration" "layer_deploy_ad_app" {
  display_name = format("%s-%s", module.naming_conv.naming_for_layer.automation_account.name, "deploy-app")
}

resource "azuread_application_password" "layer_deploy_ad_app_pw" {
  application_id = azuread_application_registration.layer_deploy_ad_app.id
}

resource "azuread_service_principal" "layer_deploy_app_sa" {
  client_id               = azuread_application_registration.layer_deploy_ad_app.client_id
  app_role_assignment_required = false
  owners = [data.azurerm_client_config.current.object_id]
}

resource "azurerm_role_assignment" "layer_role_assignment" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.layer_deploy_role.role_definition_resource_id
  principal_id       = azuread_service_principal.layer_deploy_app_sa.object_id
}