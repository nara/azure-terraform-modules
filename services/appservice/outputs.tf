# output "name" {
#   value       = azurerm_container_app_environment.managed_environment.name
#   description = "Specifies the name of the managed environment."
# }

# output "id" {
#   value       = azurerm_container_app_environment.managed_environment.id
#   description = "Specifies the resource id of the managed environment."
# }

output "azurerm_linux_web_app_default_hostname" {
    value = azurerm_linux_web_app.linux_web_app[0].default_hostname
}

output "app_service_id" {
    value = azurerm_linux_web_app.linux_web_app[0].id
}

output "app_service_name" {
    value = azurerm_linux_web_app.linux_web_app[0].name
}