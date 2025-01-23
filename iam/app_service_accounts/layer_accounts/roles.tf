data "azurerm_subscription" "primary" {
}

resource "azurerm_role_definition" "layer_deploy_role" {
  name        = format("%s-%s", module.naming_conv.naming_for_layer.role_definition.name, "deploy-role") 
  scope       = data.azurerm_subscription.primary.id

  permissions {
    actions     = concat(local.all_permissions_read, local.regional_permissions_write)
    not_actions = []
    data_actions = local.data_all_permissions_read
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id, # /subscriptions/00000000-0000-0000-0000-000000000000
  ]
}