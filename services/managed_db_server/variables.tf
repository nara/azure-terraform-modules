variable "org_key" {
  description = "The organization 3 letter word"
  type        = string
}

variable "org_email_domain" {
  description = "The organization domain (e.g. example.com )"
  type        = string
}

variable "line_of_business_key" {
  description = "A 3 letter word for line of business that is unique in org"
  type        = string
}

variable "team_key" {
  description = "Opitonal. A 3 letter word for team managing the resources in this project"
  type        = string
  default     = ""
}

variable "app_key" {
  description = "A 3 letter app key that is unique in org"
  type        = string
}

variable "environment" {
  description = "A max 4 letter word explaining the environment the resources belong to. e.g. dev, qa, uat, stg, prod"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

# Define the module inputs
variable "db_type" {
  type        = string
  description = "Type of the database. acceptable values are sql_mi, pg_flex, mysql_mi"
  default     = "sql_mi"
}

variable "name" {
  type        = string
  description = "The name of the managed instance."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the managed instance should be created."
}

variable "admin_username" {
  type        = string
  description = "The administrator username for the managed instance."
}

variable "admin_password" {
  type        = string
  description = "The administrator password for the managed instance."
}

variable "sku_name" {
  type        = string
  description = "sku_name, acceptable values are GP_Gen4, GP_Gen5, BC_Gen4, BC_Gen5"
  default     = "GP_Gen5"
}

variable "vcores" {
  type        = number
  description = "VCPU cores for sql server. Number of cores that should be assigned to your instance. Values can be 8, 16, or 24 if sku_name is GP_Gen4, or 8, 16, 24, 32, or 40 if sku_name is GP_Gen5."
  default     = 4
}

variable "storage_size_in_gb" {
  type        = number
  description = "Min SQL storage. Maximum storage space for your instance. It should be a multiple of 32GB"
  default     = 32
}

variable "license_type" {
  type        = string
  description = "License Type, acceptable values are BasePrice, LicenseIncluded"
  default     = "BasePrice"
}

variable "collation" {
  type        = string
  description = "Collation for SQL Server"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "public_data_endpoint_enabled" {
  type        = bool
  description = "If public datapoint is enabled or not"
  default     = false
}

variable "minimum_tls_version" {
  type        = number
  description = "The Minimum TLS Version. Default value is 1.2 Valid values include 1.0, 1.1, 1.2"
  default     = 1.2
}

variable "proxy_override" {
  type        = string
  description = "Specifies how the SQL Managed Instance will be accessed. Default value is Default. Valid values include Default, Proxy, and Redirect."
  default     = "Default"
}

variable "timezone_id" {
  type        = string
  description = "The TimeZone ID that the SQL Managed Instance will be operating in. Default value is UTC. Changing this forces a new resource to be created"
  default     = "UTC"
}

variable "dns_zone_partner_id" {
  type        = string
  description = "The ID of the Managed Instance which will share the DNS zone. This is a prerequisite for creating a azurerm_sql_managed_instance_failover_group. Setting this after creation forces a new resource to be created."
  default     = null
}

variable "storage_account_type" {
  type        = string
  description = "Specifies the storage account type used to store backups for this database. Changing this forces a new resource to be created. Possible values are GRS, LRS and ZRS. The default value is GRS"
  default     = "GRS"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the server"
  default     = {}
}

variable "vnet_subnet_id" {
  type        = string
  description = "The ID of the subnet where the managed instance should be deployed."
}

variable "maintenance_configuration_name" {
  type        = string
  description = "The name of the Public Maintenance Configuration window to apply to the SQL Managed Instance. Valid values include SQL_Default or an Azure Location in the format SQL_{Location}_MI_{Size}(for example SQL_EastUS_MI_1). Defaults to SQL_Default."
  default     = "SQL_Default"
}

#postgres flex
variable "authentication" {
  description = " An authentication block as defined below."
  type = object({
    active_directory_auth_enabled = optional(string)
    password_auth_enabled         = optional(string)
    tenant_id                     = optional(string)
  })
  default = null
}

variable "backup_retention_days" {
  description = " The backup retention days for the PostgreSQL Flexible Server. Possible values are between 7 and 35 days."
  type        = string
  default     = null
}

variable "customer_managed_key" {
  description = " A customer_managed_key block as defined below. Changing this forces a new resource to be created."
  type = object({
    key_vault_key_id                  = optional(string)
    primary_user_assigned_identity_id = optional(string)
  })
  default = null
}

variable "geo_redundant_backup_enabled" {
  description = " Is Geo-Redundant backup enabled on the PostgreSQL Flexible Server. Defaults to false. Changing this forces a new PostgreSQL Flexible Server to be created."
  type        = bool
  default     = false
}

variable "create_mode" {
  description = " The creation mode which can be used to restore or replicate existing servers. Possible values are Default, PointInTimeRestore, Replica and Update. Changing this forces a new PostgreSQL Flexible Server to be created."
  type        = string
  default     = "Default"
}

variable "delegated_subnet_id" {
  description = " The ID of the virtual network subnet to create the PostgreSQL Flexible Server. The provided subnet should not have any other resource deployed in it and this subnet will be delegated to the PostgreSQL Flexible Server, if not already delegated. Changing this forces a new PostgreSQL Flexible Server to be created."
  type        = string
  default     = null
}

variable "private_dns_zone_id" {
  description = " The ID of the private DNS zone to create the PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created."
  type        = string
  default     = null
}

variable "high_availability" {
  description = " A high_availability block as defined below."
  type = object({
    mode                      = string
    standby_availability_zone = optional(string)
  })
  default = null
}

variable "identity" {
  description = " An identity block as defined below."
  type = object({
    type         = string
    identity_ids = optional(string)
  })
  default = null
}

variable "maintenance_window" {
  description = " A maintenance_window block as defined below."
  type = object({
    day_of_week  = optional(string)
    start_hour   = optional(string)
    start_minute = optional(string)
  })
  default = null
}

variable "point_in_time_restore_time_in_utc" {
  description = " The point in time to restore from source_server_id when create_mode is PointInTimeRestore. Changing this forces a new PostgreSQL Flexible Server to be created."
  type        = string
  default     = null
}

variable "replication_role" {
  description = " The replication role for the PostgreSQL Flexible Server. Possible value is None."
  type        = string
  default     = null
}

variable "source_server_id" {
  description = " The resource ID of the source PostgreSQL Flexible Server to be restored. Required when create_mode is PointInTimeRestore or Replica. Changing this forces a new PostgreSQL Flexible Server to be created."
  type        = string
  default     = null
}

variable "storage_mb" {
  description = " The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, and 16777216."
  type        = string
  default     = "32768"
}


variable "zone" {
  description = " Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located."
  type        = string
  default     = null
}

variable "server_version" {
  description = " The version of PostgreSQL Flexible Server to use. Possible values are 11,12, 13 and 14. Required when create_mode is Default. Changing this forces a new PostgreSQL Flexible Server to be created."
  type        = string
  default     = "14"
}

variable "pg_flex_sku_name" {
  description = " The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3)."
  type        = string
  default     = "B_Standard_B1ms"
}

#pg

variable "pg_sku_name" {
  description = " Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8). For more information see the product documentation. Possible values are B_Gen4_1, B_Gen4_2, B_Gen5_1, B_Gen5_2, GP_Gen4_2, GP_Gen4_4, GP_Gen4_8, GP_Gen4_16, GP_Gen4_32, GP_Gen5_2, GP_Gen5_4, GP_Gen5_8, GP_Gen5_16, GP_Gen5_32, GP_Gen5_64, MO_Gen5_2, MO_Gen5_4, MO_Gen5_8, MO_Gen5_16 and MO_Gen5_32."
  type        = string
  default = "GP_Gen4_2"
}

variable "auto_grow_enabled" {
  description = " Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true."
  type        = string
  default     = null
}

variable "creation_source_server_id" {
  description = " For creation modes other than Default, the source server ID to use."
  type        = string
  default     = null
}

# variable "identity" {
#   description = " An identity block as defined below."
#   type = object({
#     type                       = string
#     enabled                    = optional(string)
#     disabled_alerts            = optional(string)
#     email_account_admins       = optional(bool)
#     email_addresses            = optional(string)
#     retention_days             = optional(string)
#     storage_account_access_key = optional(string)
#     storage_endpoint           = optional(string)
#   })
#   default = null
# }

variable "infrastructure_encryption_enabled" {
  description = " Whether or not infrastructure is encrypted for this server. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = " Whether or not public network access is allowed for this server. Defaults to true."
  type        = string
  default     = true
}

variable "restore_point_in_time" {
  description = " When create_mode is PointInTimeRestore the point in time to restore from creation_source_server_id. It should be provided in RFC3339 format, e.g. 2013-11-08T22:00:40Z."
  type        = string
  default     = null
}

variable "ssl_enforcement_enabled" {
  description = " Specifies if SSL should be enforced on connections. Possible values are true and false."
  type        = bool
  default     = false
}

variable "ssl_minimal_tls_version_enforced" {
  description = " The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2."
  type        = string
  default     = "TLSEnforcementDisabled"
}

variable "threat_detection_policy" {
  description = " Threat detection policy configuration, known in the API as Server Security Alerts Policy. The threat_detection_policy block supports fields documented below."
  type        = string
  default     = null
}