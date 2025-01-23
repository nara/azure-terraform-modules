output "sa" {
  value       = local.create_sa ? azurerm_storage_account.sa[0] : null
  sensitive   = true
  description = "The Storage Account object."
}

output "name" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].name : ""
  description = "The name of the Storage Account."
}

output "id" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].id : var.storage_account_id
  description = "The ID of the Storage Account."
}

output "primary_access_key" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_access_key : null
  sensitive   = true
  description = "The primary access key for the storage account."
}

output "secondary_access_key" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_access_key : null
  sensitive   = true
  description = "The secondary access key for the storage account."
}

output "primary_blob_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_blob_endpoint : null
  description = "The endpoint URL for blob storage in the primary location."
}

output "primary_blob_host" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_blob_host : null
  description = "The endpoint host for blob storage in the primary location."
}

output "secondary_blob_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_blob_endpoint : null
  description = "The endpoint URL for blob storage in the secondary location."
}

output "secondary_blob_host" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_blob_host : null
  description = "The endpoint host for blob storage in the secondary location."
}

output "primary_queue_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_queue_endpoint : null
  description = "The endpoint URL for queue storage in the primary location."
}

output "secondary_queue_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_queue_endpoint : null
  description = "The endpoint URL for queue storage in the secondary location."
}

output "primary_table_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_table_endpoint : null
  description = "The endpoint URL for table storage in the primary location."
}

output "secondary_table_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_table_endpoint : null
  description = "The endpoint URL for table storage in the secondary location."
}

output "primary_file_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_file_endpoint : null
  description = "The endpoint URL for file storage in the primary location."
}

output "secondary_file_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_file_endpoint : null
  description = "The endpoint URL for file storage in the secondary location."
}

output "primary_dfs_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_dfs_endpoint : null
  description = "The endpoint URL for DFS storage in the primary location."
}

output "secondary_dfs_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_dfs_endpoint : null
  description = "The endpoint URL for DFS storage in the secondary location."
}

output "primary_web_host" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_web_host : null
  description = "Hostname with port for web storage in the primary location."
}

output "primary_web_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_web_endpoint : null
  description = "The endpoint URL for web storage in the primary location."
}

output "secondary_web_host" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_web_host : null
  description = "Hostname with port for web storage in the secondary location."
}

output "secondary_web_endpoint" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_web_endpoint : null
  description = "The endpoint URL for web storage in the secondary location."
}

output "primary_connection_string" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_connection_string : null
  sensitive   = true
  description = "The connection string associated with the primary location."
}

output "secondary_connection_string" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_connection_string : null
  sensitive   = true
  description = "The connection string associated with the secondary location."
}

output "primary_blob_connection_string" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].primary_blob_connection_string : null
  sensitive   = true
  description = "The connection string associated with the primary blob location."
}

output "secondary_blob_connection_string" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].secondary_blob_connection_string : null
  sensitive   = true
  description = "The connection string associated with the secondary blob location."
}

output "principal_id" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].identity.0.principal_id : null
  description = "The Principal ID for the Service Principal associated with the Identity of this Storage Account."
}

output "tenant_id" {
  value       = local.create_sa ? azurerm_storage_account.sa[0].identity.0.tenant_id : null
  description = "The Tenant ID for the Service Principal associated with the Identity of this Storage Account."
}

output "encryption_scope_ids" {
  description = "encryption scope info."
  value = { for k, v in var.encryption_scopes :
    k => azurerm_storage_encryption_scope.scope[k].id
  }
}