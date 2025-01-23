# resource "azurerm_app_service_virtual_network_swift_connection" "app_service_vnet_integration" {
#   count          = var.app_service_vnet_integration_subnet_id == null ? 0 : 1
#   app_service_id = azurerm_linux_web_app.linux_web_app[0].id
#   subnet_id      = var.app_service_vnet_integration_subnet_id
# }

# resource "azurerm_app_service_slot_virtual_network_swift_connection" "app_service_slot_vnet_integration" {
#   count          = var.staging_slot_enabled && var.app_service_vnet_integration_subnet_id != null ? 1 : 0
#   slot_name      = azurerm_linux_web_app_slot.app_service_linux_container_slot[0].name
#   app_service_id = azurerm_linux_web_app.container_app.id
#   subnet_id      = var.app_service_vnet_integration_subnet_id
# }