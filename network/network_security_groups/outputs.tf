output "nsg_data_by_subnet_name" {
  value = { for item in local.nsg_type_versions: item.subnet.subnet_name => {
    id: module.network-security-group[item.key].nsg_data.id,
    name: module.network-security-group[item.key].nsg_data.name,
    subnet_name: item.subnet.subnet_name
  } }
}

output "nsg_test" {
  value = local.nsg_type_versions
}