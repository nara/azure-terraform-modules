resource "azurerm_search_service" "search" {
  name                = var.search_name
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = var.sku
  replica_count       = var.replica_count
  partition_count     = var.partition_count
}