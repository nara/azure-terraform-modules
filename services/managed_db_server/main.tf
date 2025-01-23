resource "azurerm_mssql_managed_instance" "sql_managed_instance" {
  count                        = var.db_type == "sql_mi" ? 1 : 0
  name                         = module.naming_conv.db_instance_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  subnet_id          = var.vnet_subnet_id
  sku_name           = var.sku_name
  vcores             = var.vcores
  storage_size_in_gb = var.storage_size_in_gb

  license_type                   = var.license_type
  collation                      = var.collation
  public_data_endpoint_enabled   = var.public_data_endpoint_enabled
  minimum_tls_version            = var.minimum_tls_version
  proxy_override                 = var.proxy_override
  timezone_id                    = var.timezone_id
  dns_zone_partner_id            = var.dns_zone_partner_id
  storage_account_type           = var.storage_account_type
  tags                           = var.tags
  maintenance_configuration_name = var.maintenance_configuration_name
}

resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  count                  = var.db_type == "pg_flex" ? 1 : 0
  name                   = var.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.admin_username
  administrator_password = var.admin_password

  dynamic "authentication" {
    for_each = var.authentication != null ? [var.authentication] : []
    content {
      active_directory_auth_enabled = lookup(authentication.value, "active_directory_auth_enabled", null)
      password_auth_enabled         = lookup(authentication.value, "password_auth_enabled", null)
      tenant_id                     = lookup(authentication.value, "tenant_id", null)

    }
  }
  backup_retention_days = var.backup_retention_days

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []
    content {
      key_vault_key_id                  = lookup(customer_managed_key.value, "key_vault_key_id", null)
      primary_user_assigned_identity_id = lookup(customer_managed_key.value, "primary_user_assigned_identity_id", null)

    }
  }
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  create_mode                  = var.create_mode
  delegated_subnet_id          = var.delegated_subnet_id
  private_dns_zone_id          = var.private_dns_zone_id

  dynamic "high_availability" {
    for_each = var.high_availability != null ? [var.high_availability] : []
    content {
      mode                      = lookup(high_availability.value, "mode", null)
      standby_availability_zone = lookup(high_availability.value, "standby_availability_zone", null)

    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)

    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []
    content {
      day_of_week  = lookup(maintenance_window.value, "day_of_week", null)
      start_hour   = lookup(maintenance_window.value, "start_hour", null)
      start_minute = lookup(maintenance_window.value, "start_minute", null)

    }
  }
  point_in_time_restore_time_in_utc = var.point_in_time_restore_time_in_utc
  replication_role                  = var.replication_role
  sku_name                          = var.pg_flex_sku_name
  source_server_id                  = var.source_server_id
  storage_mb                        = var.storage_mb
  tags                              = var.tags
  version                           = var.server_version
  zone                              = var.zone
}


resource "azurerm_postgresql_server" "postgresql_server" {
  count                        = var.db_type == "pg" ? 1 : 0
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  sku_name                     = var.pg_sku_name
  version                      = var.server_version
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  auto_grow_enabled            = var.auto_grow_enabled
  backup_retention_days        = var.backup_retention_days
  create_mode                  = var.create_mode
  creation_source_server_id    = var.creation_source_server_id
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type                       = lookup(identity.value, "type", null)
    }
  }
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  restore_point_in_time             = var.restore_point_in_time
  ssl_enforcement_enabled           = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced
  storage_mb                        = var.storage_mb
  tags                              = var.tags
}