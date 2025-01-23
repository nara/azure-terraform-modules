output "vnet_test" {
  value = module.network_security_groups.nsg_test
}

output "app_layer_config" {
    value = local.app_layer_config
}