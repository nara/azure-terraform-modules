module "naming_conv"{
  source = "../../foundation/naming_conv"
  #source = "git::https://github.com/nara-alz-org/modules.git//azure/foundation/naming_conv"
  app_key = var.app_key
  environment = var.environment
  line_of_business_key = var.line_of_business_key
  org_email_domain = var.org_email_domain
  org_key = var.org_key
  location = var.location
  team_key = var.team_key
  location_short = var.location_short
  db_type = ""
}

data "local_file" "rule_json_file" {
   for_each = {for idx, item in local.nsg_type_versions : item.key => item}
   filename = "${path.module}/rules/${each.value.type}/${each.value.version}.json"
}

data "azurerm_subnet" "subnet" {
  for_each = { for item in var.subnet_config : item.name => item }
  name = each.key
  virtual_network_name = each.value.vnet_name
  resource_group_name  = var.resource_group_name
}