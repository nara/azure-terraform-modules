resource "azurerm_postgresql_flexible_server_database" "postgresql_flexible_server_database" {
  count     = var.db_type == "pg_flex" ? 1 : 0
  name      = var.db_name
  server_id = var.server_id
  charset   = var.charset
  collation = var.collation
}

resource "azurerm_postgresql_database" "postgresql_database" {
  count               = var.db_type == "pg" ? 1 : 0
  name                = var.db_name
  server_name         = var.server_name
  resource_group_name = var.resource_group_name
  charset             = var.charset
  collation           = var.collation
}