output "vnet_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = local.azurerm_subnets[*].id
}

output "vnet_subnets_name_id" {
  description = "Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = local.azurerm_subnets_name_id_map
}
