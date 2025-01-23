resource "azurerm_service_plan" "service_plan" {
  count = var.service_plan_id == "" ? 1 : 0
  name                         = module.naming_conv.naming_for_app.app_service_plan.name
  location                     = var.location
  os_type                      = var.os_type
  resource_group_name          = var.resource_group_name
  sku_name                     = var.sku_name
  app_service_environment_id   = var.app_service_environment_id
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  worker_count                 = var.worker_count
  per_site_scaling_enabled     = var.per_site_scaling_enabled
  zone_balancing_enabled       = var.zone_balancing_enabled
  tags                         = var.tags
}