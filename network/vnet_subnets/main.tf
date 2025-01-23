module "naming_conv" {
  source = "../../foundation/naming_conv"
  #source = "git::https://github.com/nara-alz-org/modules.git//azure/foundation/naming_conv"
  app_key = var.app_key
  environment = var.environment
  line_of_business_key = var.line_of_business_key
  org_email_domain = var.org_email_domain
  org_key = var.org_key
  team_key = var.team_key
  location_short = var.location_short
  db_type              = ""
}

resource "azurerm_virtual_network" "vnet" {
  address_space       = var.address_space
  location            = var.vnet_location
  name                = var.vnet_postfix != "" ? format("%s-%s", module.naming_conv.naming_for_team.virtual_network.name, var.vnet_postfix) : module.naming_conv.naming_for_team.virtual_network.name
  resource_group_name = local.resource_group_name
  bgp_community       = var.bgp_community
  dns_servers         = var.dns_servers
  tags = var.tags

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan != null ? [var.ddos_protection_plan] : []

    content {
      enable = ddos_protection_plan.value.enable
      id     = ddos_protection_plan.value.id
    }
  }
}

module "enterprise_subnets" {
  source = "./subnet_types/enterprise"
  subnets = local.enterprise_subnets
  resource_group_name = local.resource_group_name
  subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
  subnet_enforce_private_link_service_network_policies = var.subnet_enforce_private_link_service_network_policies
  subnet_service_endpoints = var.subnet_service_endpoints
  tags = var.tags
  tracing_tags_enabled = var.tracing_tags_enabled
  tracing_tags_prefix = var.tracing_tags_prefix
  vnet_location = var.vnet_location
  vnet_name = azurerm_virtual_network.vnet.name
  route_table_name = module.naming_conv.enterprise_rtb_name
}

module "private_subnets" {
  source = "./subnet_types/private"
  subnets = local.private_subnets
  resource_group_name = local.resource_group_name
  subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
  subnet_enforce_private_link_service_network_policies = var.subnet_enforce_private_link_service_network_policies
  subnet_service_endpoints = var.subnet_service_endpoints
  tags = var.tags
  tracing_tags_enabled = var.tracing_tags_enabled
  tracing_tags_prefix = var.tracing_tags_prefix
  vnet_location = var.vnet_location
  vnet_name = azurerm_virtual_network.vnet.name
  route_table_name = module.naming_conv.private_rtb_name
}

module "network_security_groups" {
  source  = "../network_security_groups"
  #source   = "git::https://github.com/nara-alz-org/modules.git//azure/network/network_security_groups"

  app_key = var.app_key
  environment = var.environment
  line_of_business_key = var.line_of_business_key
  org_email_domain = var.org_email_domain
  org_key = var.org_key
  team_key = var.team_key
  location_short = var.location_short

  resource_group_name   = var.resource_group_name
  #location              = var.location
  tags = var.tags
  use_for_each = true
  subnet_config = local.subnet_config
  app_layers = local.app_layer_config
  rules_by_subnet = var.rules_by_subnet
  depends_on = [ 
    module.enterprise_subnets,
    module.private_subnets
   ]
}

resource "azurerm_subnet_network_security_group_association" "vnet" {
  for_each = { for idx, s in local.subnet_nsg_mapping : s.subnet_name => s }
  
  network_security_group_id = each.value.nsg_id
  subnet_id                 = each.value.subnet_id
}