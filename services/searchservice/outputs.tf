output "search_service_id" {
  value = "${azurerm_search_service.search.id}"
}

output "primary_key" {
  value = "${azurerm_search_service.search.primary_key}"
}

output "secondary_key" {
  value = "${azurerm_search_service.search.secondary_key}"
}

output "query_keys" {
  value = "${azurerm_search_service.search.query_keys}"
}
