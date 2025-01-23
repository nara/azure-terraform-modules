resource "random_id" "id" {
	  byte_length = 5
}

locals {
  team_or_app_key = var.team_key != "" ? var.team_key : var.app_key

  generic_app_prefix = format("%s-%s-%s", var.line_of_business_key, var.app_key,  var.environment)

  //rg-abc-com-cde-host-dev
  resource_group_name = format("rg-%s-%s-%s-%s", var.org_key, var.line_of_business_key, local.team_or_app_key, var.environment)

  //grp-gcp-readonly-abc-com-cde-host-dev AD groups
  group_suffix = format("%s-%s-%s-%s@%s", var.org_key, var.line_of_business_key, local.team_or_app_key, var.environment, var.org_email_domain)
  readonly_group_name = format("group:grp-az-readonly-%s", local.group_suffix)
  dev_group_name = format("group:grp-az-dev-%s", local.group_suffix)
  sre_group_name = format("group:grp-az-sre-%s", local.group_suffix)
  audit_group_name = format("group:grp-az-audit-%s", local.group_suffix)
  admin_group_name = format("group:grp-az-admin-%s", local.group_suffix)

  //service accounts
  service_account_name = format("sa-%s", local.generic_app_prefix)
  //deploy service accounts
  security_app_deploy_service_account = format("${local.service_account_name}-sec-auto")
  network_app_deploy_service_account = format("${local.service_account_name}-network-auto")
  service_app_deploy_service_account = format("${local.service_account_name}-service-auto")
  db_app_deploy_service_account = format("${local.service_account_name}-db-auto")
  
  preglobal_app_deploy_service_account = format("${local.service_account_name}-pregbl-auto")
  postglobal_app_deploy_service_account = format("${local.service_account_name}-postgbl-auto")
  regional_app_deploy_service_account = format("${local.service_account_name}-regional-auto")

  //deploy role names
  role_name_name = format("role_%s", replace(local.generic_app_prefix, "-", "_"))
  security_app_deploy_role = format("${local.role_name_name}_sec_auto")
  network_app_deploy_role = format("${local.role_name_name}_network_auto")
  service_app_deploy_role = format("${local.role_name_name}_service_auto")
  db_app_deploy_role = format("${local.role_name_name}_db_auto")
  preglobal_app_deploy_role = format("${local.role_name_name}_preglobal_auto")
  postglobal_app_deploy_role = format("${local.role_name_name}_postglobal_auto")
  regional_app_deploy_role = format("${local.role_name_name}_regional_auto")

  //app service sa
  app_service_account_name = format("${local.service_account_name}-aps")
  
  //key vault and key names
  kv_key_name = format("%s-key", local.generic_app_prefix)
  app_service_kv_key_name = format("as-${local.kv_key_name}")
  kv_name = format("%s-kv", local.generic_app_prefix)
  app_service_kv_key_ring_name = format("as-${local.kv_name}")

  //networking
  vnet_name = format("%s-%s-%s-%s-vnet", var.line_of_business_key, local.team_or_app_key,  var.environment, var.vpc_postfix)
  enterprise_subnet_name = format("%s-ent-subnet", local.vnet_name)
  enterprise_rtb_name = format("%s-ent-rtb", local.vnet_name)
  private_subnet_name = format("%s-pvt-subnet", local.vnet_name)
  private_rtb_name = format("%s-pvt-rtb", local.vnet_name)
  serverless_subnet_name = format("%s-svl-subnet", local.vnet_name)
  serverless_rtb_name = format("%s-svl-rtb", local.vnet_name)
  private_endpoint_name = format("%s-pvt-ept", local.vnet_name)
  serverless_vpc_connector_name = format("%s-%s-%s-%s-svl-con", var.line_of_business_key, local.team_or_app_key,  var.environment, var.vpc_postfix)
  #format: db.team.private.domain.com
  db_private_dns_zone_name = format("db.%s.private.%s", local.team_or_app_key, var.org_email_domain)
  app_sql_db_private_dns_zone_name = format("%s.db.%s.private.%s", var.app_key, local.team_or_app_key, var.org_email_domain)

  //db instances
  db_instance_name =  format("%s-%s-db", local.generic_app_prefix, var.db_type)

  //cloud run
  serverless_neg_name = format("%s-svl-neg", local.generic_app_prefix)

  
}

