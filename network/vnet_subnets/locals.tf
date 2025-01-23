locals {
  resource_group_name = var.resource_group_name != "" ? var.resource_group_name : module.naming_conv.naming_for_team.resource_group.name
  newbits_by_address_space = { for i, c in var.address_space : i => 
   flatten([
    for s in var.automatic_subnet_config : [
      for count in range(s.subnet_count) : s.cidr_range - tonumber(substr(element(var.address_space, s.vnet_address_space_index), -2, -1))
    ] if s.vnet_address_space_index == i ] )
  }
  #26-24,26-24,28-24,28-24
  subnet_cidrs_by_address_space = { for i, c in local.newbits_by_address_space : i => 
    cidrsubnets(element(var.address_space, i), c...)
  }
  automatic_subnets_no_prefix = flatten([
      for j, s in var.automatic_subnet_config : [
        for count in range(s.subnet_count) : {
          name = format("%s-%s-%s", module.naming_conv.naming_for_team.subnet.name, substr(s.subnet_type, 0, 3), s.subnet_postfix)
          prefix = ""
          subnet_type = s.subnet_type
          subnet_postfix = s.subnet_postfix
          service_endpoints = s.service_endpoints
          subnet_delegation = s.subnet_delegation
          vnet_address_space_index = s.vnet_address_space_index
        }
      ]
    ])
    #local.subnet_cidrs_by_address_space[s.vnet_address_space_index][j]
  automatic_subnet_with_prefix = flatten([
    for i, c in local.subnet_cidrs_by_address_space : [
      for j, s in local.automatic_subnets_no_prefix : {
        name = s.name
        prefix = c[j]
        subnet_type = s.subnet_type
        subnet_postfix = s.subnet_postfix
        service_endpoints = s.service_endpoints
        subnet_delegation = s.subnet_delegation
      } if s.vnet_address_space_index == tonumber(i)
    ]
  ])
  manual_subnets_with_names = flatten([
    for s in var.manual_subnets : [
      for count in range(s.subnet_count) : {
        name = format("%s-%s-%s", module.naming_conv.naming_for_team.subnet.name, substr(s.subnet_type, 0, 3), s.subnet_postfix)
        prefix = s.prefix
        subnet_type = s.subnet_type
        subnet_postfix = s.subnet_postfix
        service_endpoints = s.service_endpoints
        subnet_delegation = s.subnet_delegation
      }
    ]
  ])
  all_subnets = concat(local.automatic_subnet_with_prefix, local.manual_subnets_with_names)
  subnet_config = [for s in local.all_subnets : {
      name =  s.name
      subnet_name = s.name
      subnet_type = s.subnet_type
      subnet_postfix = s.subnet_postfix
      vnet_name = azurerm_virtual_network.vnet.name
    }]
  #all_subnet_ids = [for s in local.all_subnets : azurerm_subnet.subnets[s.name].id] 
  enterprise_subnets = [for s in local.all_subnets : s if s.subnet_type == "enterprise"]
  private_subnets = [for s in local.all_subnets : s if s.subnet_type == "private"]
  subnet_name_ids = merge(module.enterprise_subnets.vnet_subnets_name_id, module.private_subnets.vnet_subnets_name_id)
  subnet_nsg_mapping = [for s in local.subnet_config : {
    subnet_name = s.name
    nsg_id = module.network_security_groups.nsg_data_by_subnet_name[s.name].id
    subnet_id = local.subnet_name_ids[s.name]
  }]
  app_layer_config = [for item in var.app_layers : {
    layer_name = item.layer_name
    app_nsg_name = "asg-${var.app_key}-${item.layer_name}-${var.environment}-${var.location_short}" #asg-abf-app-dev-scus module.naming_conv.naming_for_layer.application_security_group.name
  }]
}