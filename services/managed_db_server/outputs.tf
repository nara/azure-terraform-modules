output "id" {
  value = var.db_type == "sql_mi" ? azurerm_mssql_managed_instance.sql_managed_instance[0].id : (
    var.db_type == "pg_flex") ? azurerm_postgresql_flexible_server.postgresql_flexible_server[0].id : (
    var.db_type == "pg") ? azurerm_postgresql_server.postgresql_server[0].id : ""
}

output "name" {
  value = var.db_type == "sql_mi" ? azurerm_mssql_managed_instance.sql_managed_instance[0].name : (
    var.db_type == "pg_flex") ? azurerm_postgresql_flexible_server.postgresql_flexible_server[0].name : (
    var.db_type == "pg") ? azurerm_postgresql_server.postgresql_server[0].name : ""
}

output "fqdn" {
  value = var.db_type == "sql_mi" ? azurerm_mssql_managed_instance.sql_managed_instance[0].fqdn : (
    var.db_type == "pg_flex") ? azurerm_postgresql_flexible_server.postgresql_flexible_server[0].fqdn : (
    var.db_type == "pg") ? azurerm_postgresql_server.postgresql_server[0].fqdn : ""
}

output "admin_username" {
  value = var.db_type == "sql_mi" ? azurerm_mssql_managed_instance.sql_managed_instance[0].administrator_login : (
    var.db_type == "pg_flex") ? azurerm_postgresql_flexible_server.postgresql_flexible_server[0].administrator_login : (
    var.db_type == "pg") ? azurerm_postgresql_server.postgresql_server[0].administrator_login : ""
}