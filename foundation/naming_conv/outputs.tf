output "naming_for_layer"{
  value = module.naming_for_layer
}

output "naming_for_app"{
  value = module.naming_for_app
}

output "naming_for_team"{
  value = module.naming_for_team
}

output "naming_for_central"{
  value = module.naming_for_central
}

output "common_suffix"{
  value = module.naming_suffix.common_suffix
}

output "suffix_for_layer"{
  value = module.naming_suffix.suffix_for_layer
}

output "suffix_for_app"{
  value =  module.naming_suffix.suffix_for_app
}

output "suffix_for_team"{
  value = module.naming_suffix.suffix_for_team
}

output "suffix_for_central"{
  value = module.naming_suffix.suffix_for_central
}

output "private_endpoint_url" {
  value = "${var.app_key}.${var.location_short}.${var.environment}.${var.org_key}.com"
}

output "resource_group_name" {
  value = local.resource_group_name
}

output "readonly_group_name" {
  value = local.readonly_group_name
}

output "dev_group_name" {
  value = local.dev_group_name
}

output "sre_group_name" {
  value = local.sre_group_name
}

output "audit_group_name" {
  value = local.audit_group_name
}

output "admin_group_name" {
  value = local.admin_group_name
}

output "service_account_name" {
  value = local.service_account_name
}

output "app_service_account_name" {
  value = local.app_service_account_name
}

output "keyvault_name" {
  value = local.kv_name
}

output "app_service_kv_key_name" {
  value = local.app_service_kv_key_name
}

output "app_service_kv_key_ring_name" {
  value = local.app_service_kv_key_ring_name
}

output "vnet_name" {
  value = local.vnet_name
}

output "enterprise_subnet_name" {
  value = local.enterprise_subnet_name
}

output "serverless_subnet_name" {
  value = local.serverless_subnet_name
}

output "private_endpoint_name" {
  value = local.private_endpoint_name
}

output "enterprise_rtb_name" {
  value = local.enterprise_rtb_name
}

output "serverless_rtb_name" {
  value = local.serverless_rtb_name
}

output "private_rtb_name" {
  value = local.private_rtb_name
}

output "serverless_vpc_connector_name" {
  value = local.serverless_vpc_connector_name
}

output "db_instance_name" {
  value = local.db_instance_name
}

output "serverless_neg_name" {
  value = local.serverless_neg_name
}

output "db_private_dns_zone_name" {
  value = local.db_private_dns_zone_name
}

output "app_sql_db_private_dns_zone_name" {
  value = local.app_sql_db_private_dns_zone_name
}

output "generic_app_prefix" {
  value = local.generic_app_prefix
}

output "security_app_deploy_service_account" {
  value = local.security_app_deploy_service_account
}

output "network_app_deploy_service_account" {
  value = local.network_app_deploy_service_account
}

output "service_app_deploy_service_account" {
  value = local.service_app_deploy_service_account
}

output "db_app_deploy_service_account" {
  value = local.db_app_deploy_service_account
}

output "preglobal_app_deploy_service_account" {
  value = local.preglobal_app_deploy_service_account
}

output "postglobal_app_deploy_service_account" {
  value = local.postglobal_app_deploy_service_account
}

output "regional_app_deploy_service_account" {
  value = local.regional_app_deploy_service_account
}

output "automation_sa_name_map" {
  value = {
    "security" = local.security_app_deploy_service_account,
    "network" = local.network_app_deploy_service_account,
    "service" = local.service_app_deploy_service_account,
    "db" = local.db_app_deploy_service_account,
    "preglobal" = local.preglobal_app_deploy_service_account,
    "postglobal" = local.postglobal_app_deploy_service_account,
    "regional" = local.regional_app_deploy_service_account,
  }
}

output "automation_role_name_map" {
  value = {
    "security" = local.security_app_deploy_role,
    "network" = local.network_app_deploy_role,
    "service" = local.service_app_deploy_role,
    "db" = local.db_app_deploy_role,
    "preglobal" = local.preglobal_app_deploy_role,
    "postglobal" = local.postglobal_app_deploy_role,
    "regional" = local.regional_app_deploy_role,
  }
}

output "location_short" {
  value = module.naming_suffix.location_short
}