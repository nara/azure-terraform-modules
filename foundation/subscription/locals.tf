locals {
  billing_scope_id = var.billing_account_type == "MPA" && var.billing_mpa_account_scope != null ? data.azurerm_billing_mpa_account_scope.this[0].id : (
                     var.billing_account_type == "MCA" && var.billing_mca_account_scope != null ? data.azurerm_billing_mca_account_scope.this[0].id :
                     var.billing_account_type == "EA" && var.billing_enrollment_account_scope != null ? data.azurerm_billing_enrollment_account_scope.this[0].id : null )

  consumption_budget_defaults = {
    time_grain = "Monthly"
    consumption_budget_start_date = (length(time_static.consumption_budget_start_date) == 0 ? null :
    formatdate("YYYY-MM-01'T'00:00:00Z", one(time_static.consumption_budget_start_date[*].rfc3339)))
    notifications = {
      contact_emails = var.default_consumption_budget_notification_emails
      operator       = "EqualTo"
      threshold      = "90.0"
      threshold_type = "Actual"
    }
  }

  diagnostics_categories_flag_map = merge({
    Administrative = true
    Security       = true
    Alert          = true
    Policy         = true
    Autoscale      = true
    Recommendation = true
    ServiceHealth  = true
  }, var.diagnostics_categories_flag_map)

  alias_id                 = one(azurerm_subscription.this[*].id)
  subscription_resource_id = "/subscriptions/${one(azurerm_subscription.this[*].subscription_id)}"
  subscription_id          = one(azurerm_subscription.this[*].subscription_id)
  subscription_name        = one(azurerm_subscription.this[*].subscription_name)
}