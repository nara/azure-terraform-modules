locals {
  enterprise_routes = [
    for idx, s in data.azurerm_virtual_network.vnet.address_space : {
      name = "local_enterprise_route_${idx}"
      address_prefix = s
      next_hop_type = "VnetLocal"
      next_hop_in_ip_address = null
    }
  ]
  azurerm_subnets = [for s in azurerm_subnet.subnets : s]
  azurerm_subnets_name_id_map = {
    for index, subnet in local.azurerm_subnets :
    subnet.name => subnet.id
  }
}
# app creates subscriptions, adds vnet, subnets, and route tables
# can add new vnet or subnet to existing vnet. can create peering
# enterprise subnet - connectivity to tgw?
