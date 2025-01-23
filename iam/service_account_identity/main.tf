#sa
resource "azuread_application_registration" "app_reg" {
  display_name = var.app_registration_name #("%s-%s", "adapp", module.naming_conv.suffix_for_layer)
}

resource "azuread_application_password" "ad_app_pw" {
  application_id = azuread_application_registration.app_reg.id
}

resource "azuread_service_principal" "app_sa" {
  client_id               = azuread_application_registration.app_reg.client_id
  app_role_assignment_required = false
  owners = [data.azurerm_client_config.current.object_id]
}

resource "azurerm_role_assignment" "sa_role_assignments" {
  for_each = var.assign_roles_to_sa
  scope              = each.key
  role_definition_name = each.value
  principal_id       = azuread_service_principal.app_sa.object_id
}

resource "azurerm_user_assigned_identity" "identity" {
  count = var.create_user_identity ? 1 : 0
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.user_assigned_identity_name #module.naming_conv.naming_for_layer.user_assigned_identity.name
}

resource "azurerm_role_assignment" "ra2" {
  count                = var.create_user_identity ? 1 : 0
  scope                = azurerm_user_assigned_identity.identity[0].id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azuread_service_principal.app_sa.object_id
  depends_on           = [azurerm_user_assigned_identity.identity]
}

resource "azurerm_role_assignment" "ui_role_assignments" {
  for_each = var.create_user_identity ? var.assign_roles_to_user_identity : {}
  scope              = each.key
  role_definition_name = each.value
  principal_id       = azurerm_user_assigned_identity.identity[0].principal_id
}