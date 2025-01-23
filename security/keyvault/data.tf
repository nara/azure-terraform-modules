data "azurerm_client_config" "current" {}

data "azurerm_monitor_diagnostic_categories" "default" {
  resource_id = azurerm_key_vault.main.id
}