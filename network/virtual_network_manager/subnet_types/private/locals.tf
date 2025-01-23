locals {
  azurerm_subnets = [for s in azurerm_subnet.subnets : s]
  azurerm_subnets_name_id_map = {
    for index, subnet in local.azurerm_subnets :
    subnet.name => subnet.id
  }
}