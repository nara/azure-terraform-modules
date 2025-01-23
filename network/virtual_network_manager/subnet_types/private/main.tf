resource "azurerm_subnet" "subnets" {
  for_each = { for idx, s in var.subnets : s.name => s }

  address_prefixes                               = [each.value.prefix]
  name                                           = each.key
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = var.vnet_name
  enforce_private_link_endpoint_network_policies = lookup(var.subnet_enforce_private_link_endpoint_network_policies, each.key, false)
  enforce_private_link_service_network_policies  = lookup(var.subnet_enforce_private_link_service_network_policies, each.key, false)
  service_endpoints                              = each.value.service_endpoints

  dynamic "delegation" {
    for_each = each.value.subnet_delegation

    content {
      name = delegation.key

      service_delegation {
        name    = lookup(delegation.value, "service_name")
        actions = lookup(delegation.value, "service_actions", [])
      }
    }
  }
}

# resource "azurerm_subnet_network_security_group_association" "vnet" {
#   for_each = var.nsg_ids

#   network_security_group_id = each.value
#   subnet_id                 = local.azurerm_subnets_name_id_map[each.key]
# }

# resource "azurerm_subnet_route_table_association" "vnet" {
#   for_each = var.route_tables_ids

#   route_table_id = each.value
#   subnet_id      = local.azurerm_subnets_name_id_map[each.key]
# }