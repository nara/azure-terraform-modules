output "azure_bastion_public_ip" {
  description = "The public IP of the virtual network gateway"
  value       = element(concat([azurerm_public_ip.pip.ip_address], [""]), 0)
}

output "azure_bastion_public_ip_fqdn" {
  description = "Fully qualified domain name of the virtual network gateway"
  value       = element(concat([azurerm_public_ip.pip.fqdn], [""]), 0)
}

output "azure_bastion_host_id" {
  description = "The resource ID of the Bastion Host"
  value       = azurerm_bastion_host.main.id
}

output "azure_bastion_host_fqdn" {
  description = "The fqdn of the Bastion Host"
  value       = azurerm_bastion_host.main.dns_name
}