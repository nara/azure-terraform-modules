data "azurerm_resource_group" "nsg" {
  name = var.resource_group_name
}

module "network-security-group" {
  for_each = {for idx, item in local.nsg_type_versions : item.name => item}

  source                = "../../foundation/network_security_group"

  app_key = var.app_key
  environment = var.environment
  line_of_business_key = var.line_of_business_key
  org_email_domain = var.org_email_domain
  org_key = var.org_key
  team_key = var.team_key
  
  
  resource_group_name   = var.resource_group_name
  location              = var.location
  security_group_name   = format("%s-%s", module.naming_conv.naming_for_team.network_security_group.name, each.value.key)

  predefined_rules = lookup(local.rules_by_subnet, each.value.subnet.subnet_name, { "predefined_rules" = [] }).predefined_rules
  custom_rules = concat(local.nsg_type_version_data[each.value.name].content, 
    lookup(local.rules_by_subnet, each.value.subnet.subnet_name, { "custom_rules" = [] }).custom_rules)
  #custom_rules = []
  tags = merge(var.tags, { "release": each.value.version })
  rules = var.rules
  use_for_each = true
  app_layer_ids = local.app_layer_ids
  depends_on = [ azurerm_application_security_group.app_security_groups ]
}

resource "azurerm_application_security_group" "app_security_groups" {
  for_each = { for value in var.app_layers : value.layer_name => value }
  name                = each.value.app_nsg_name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.nsg.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}