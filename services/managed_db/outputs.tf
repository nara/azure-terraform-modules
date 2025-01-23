output "id" {
  value = var.db_type == "pg_flex" ? azurerm_postgresql_flexible_server_database.postgresql_flexible_server_database[0].id : ""
}