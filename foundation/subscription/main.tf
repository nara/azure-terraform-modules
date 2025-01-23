data "azurerm_billing_mpa_account_scope" "this" {
  count = var.billing_account_type == "MPA" && var.billing_mpa_account_scope != null ? 1 : 0

  billing_account_name = var.billing_mpa_account_scope.billing_account_id

  customer_name               = var.billing_mpa_account_scope.customer_id
}

data "azurerm_billing_mca_account_scope" "this" {
  count = var.billing_account_type == "MCA" && var.billing_mca_account_scope != null ? 1 : 0

  billing_account_name = var.billing_mca_account_scope.billing_account_id
  billing_profile_name               = var.billing_mca_account_scope.billing_profile_id
  invoice_section_name = var.billing_mca_account_scope.invoice_section_id
}

data "azurerm_billing_enrollment_account_scope" "this" {
  count = var.billing_account_type == "EA" && var.billing_enrollment_account_scope != null ? 1 : 0

  billing_account_name    = var.billing_enrollment_account_scope.billing_account_id
  enrollment_account_name = var.billing_enrollment_account_scope.enrollment_account_id
}

resource "azurerm_subscription" "this" {
  
  subscription_name = var.subscription_name
  alias             = var.subscription_name

  billing_scope_id = local.billing_scope_id

  tags = var.tags
  timeouts {
    create = "60m"
    update = "60m"
  }
}

resource "time_static" "consumption_budget_start_date" {
  count = length(var.consumption_budgets) > 0 ? 1 : 0
}

resource "azurerm_consumption_budget_subscription" "this" {
  for_each = var.consumption_budgets

  name            = each.key
  subscription_id = local.subscription_resource_id

  amount     = each.value["amount"]
  time_grain = lookup(each.value, "time_grain", local.consumption_budget_defaults.time_grain)

  time_period {
    start_date = coalesce(
      lookup(lookup(each.value, "time_period", {}), "start_date", null),
      local.consumption_budget_defaults.consumption_budget_start_date
    )
    end_date = try(each.value.time_period.end_date, null)
  }

  dynamic "notification" {
    for_each = each.value["notifications"]
    content {
      contact_emails = lookup(notification.value, "contact_emails", local.consumption_budget_defaults.notifications.contact_emails)
      operator       = lookup(notification.value, "operator", local.consumption_budget_defaults.notifications.operator)
      threshold      = lookup(notification.value, "threshold", local.consumption_budget_defaults.notifications.threshold)
      threshold_type = lookup(notification.value, "threshold_type", local.consumption_budget_defaults.notifications.threshold_type)
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.diagnostics_log_analytics_workspace_id != null ? 1 : 0

  name = var.azurerm_monitor_diagnostic_setting_name

  target_resource_id         = local.subscription_resource_id
  log_analytics_workspace_id = var.diagnostics_log_analytics_workspace_id

  enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = false
    }
  }
  
  dynamic "log" {
    for_each = local.diagnostics_categories_flag_map
    content {
      category = log.key
      enabled  = log.value
    }
  }
}

resource "null_resource" "refresh_access_token" {
  count = var.refresh_token ? 1 : 0

  triggers = {
    subscription_id = local.subscription_id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/refresh_access_token.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail
  }

  depends_on = [azurerm_subscription.this]
}