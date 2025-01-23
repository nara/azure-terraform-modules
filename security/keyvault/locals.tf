locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)

  diag_resource_list = var.diagnostics != null ? split("/", var.diagnostics.destination) : []
  parsed_diag        = var.diagnostics != null ? {
    log_analytics_id   = contains(local.diag_resource_list, "Microsoft.OperationalInsights") ? var.diagnostics.destination : null
    storage_account_id = contains(local.diag_resource_list, "Microsoft.Storage") ? var.diagnostics.destination : null
    event_hub_auth_id  = contains(local.diag_resource_list, "Microsoft.EventHub") ? var.diagnostics.destination : null
    metric             = var.diagnostics.metrics
    log                = var.diagnostics.logs
  } : {
    log_analytics_id   = null
    storage_account_id = null
    event_hub_auth_id  = null
    metric             = []
    log                = []
  }
}

