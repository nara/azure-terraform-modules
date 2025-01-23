# resource "azurerm_route_table" "rtable" {
#   name                          = var.route_table_name
#   location                      = var.vnet_location
#   resource_group_name           = var.resource_group_name
#   disable_bgp_route_propagation = var.disable_bgp_route_propagation
# }

# resource "azurerm_route" "route" {
#   for_each = { for idx, s in local.enterprise_routes : s.name => s }
#   name                = each.key
#   resource_group_name = var.resource_group_name
#   route_table_name    = azurerm_route_table.rtable.name
#   address_prefix      = each.value.address_prefix
#   next_hop_type       = each.value.next_hop_type
#   next_hop_in_ip_address = each.value.next_hop_in_ip_address
# }