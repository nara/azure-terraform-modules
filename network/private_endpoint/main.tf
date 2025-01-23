resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = format("%s-conn", var.private_endpoint_name)
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = false
    subresource_names = var.subresource_names
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

data "azurerm_private_endpoint_connection" "private_connection" {
  name                = azurerm_private_endpoint.private_endpoint.name
  resource_group_name = var.resource_group_name
  depends_on = [ 
    azurerm_private_endpoint.private_endpoint,
    azurerm_private_dns_zone.private_dns_zone,
    azurerm_private_dns_zone_virtual_network_link.dns_zone_to_vnet_link
   ]
}

# resource "azurerm_private_dns_a_record" "private_dns_zone_a_record" {
#   name                = module.naming_conv.app_sql_db_private_dns_zone_name
#   zone_name           = azurerm_private_dns_zone.private_dns_zone.name
#   resource_group_name = var.resource_group_name
#   ttl                 = 300
#   records             = [data.azurerm_private_endpoint_connection.private_connection.private_service_connection.0.private_ip_address]
  
#   depends_on = [ 
#     data.azurerm_private_endpoint_connection.private_connection
#   ]
# }

resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_to_vnet_link" {
  name                  = format("%s-vnet-link", var.private_dns_zone_name)
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.vnet_id
}