resource "azurerm_application_insights" "this" {
  count               = var.enable_appinsights ? 1 : 0
  name                = module.naming_conv.naming_for_app.application_insights.name
  location            = var.location
  resource_group_name = module.naming_conv.naming_for_app.resource_group.name
  application_type    = var.application_type
  workspace_id        = var.analytics_workspace_id == "" ? azurerm_log_analytics_workspace.this[0].id : var.analytics_workspace_id
  tags                = var.tags
}

data "azurerm_monitor_diagnostic_categories" "this" {
  count       = var.enable_appinsights ? 1 : 0
  resource_id = azurerm_linux_web_app.linux_web_app[0].id
}

resource "azurerm_log_analytics_workspace" "this" {
  count               = var.enable_appinsights && var.analytics_workspace_id == "" ? 1 : 0
  name                = module.naming_conv.naming_for_app.log_analytics_workspace.name
  location            = var.location
  resource_group_name = module.naming_conv.naming_for_app.resource_group.name
  sku                 = var.analytics_workspace_sku
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count                          = var.enable_appinsights ? 1 : 0
  name                           = module.naming_conv.naming_for_app.monitor_diagnostic_setting.name
  target_resource_id             = azurerm_linux_web_app.linux_web_app[0].id
  log_analytics_workspace_id     = var.analytics_workspace_id == "" ? azurerm_log_analytics_workspace.this[0].id : var.analytics_workspace_id
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].metrics
    content {
      category = metric.value
    }
  }
  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}