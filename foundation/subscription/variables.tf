variable "billing_account_type" {
  description = "The type of billing account. Accepted values: EA, MCA (microsoft customer agreement) , MOSP (Microsoft Online Services Program), MPA (Microsoft Partner Agreement)"
  type        = string
  default = "EA"
}

variable "environment" {
  type        = string
  description = "Name of the environment"
}

variable "subscription_name" {
  type        = string
  description = "Name of the subscription"
}

variable "billing_enrollment_account_scope" {
  type = object({
    billing_account_id : string
    enrollment_account_id : string
  })
  description = "Enterprise Account details. The Billing Account Id and the Enrollment Account Id."
  default     = null
}

variable "billing_mca_account_scope" { 
  type = object({
    billing_account_id : string
    billing_profile_id : string
    invoice_section_id : string
  })
  description = "Microsoft Customer Agreement Account details. The Billing Account Id, Billing Profile Id and Invoice Section Id."
  default     = null
}

variable "billing_mpa_account_scope" { 
  type = object({
    billing_account_id : string
    customer_id : string
  })
  description = "Microsoft Partner Agreement Account details. The Billing Account Id and Customer Id."
  default     = null
}

variable "refresh_token" {
  type        = bool
  description = "Indicates wherever the refresh token of service principal should be refreshed after the subscription is created."
  default     = false
}

variable "diagnostics_log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "Resource ID of the log analytics workspace. Used for diagnostics logs and metrics"
}

variable "diagnostics_categories_flag_map" {
  type        = map(bool)
  default     = {}
  description = "Map of Diagnostic categories. By default all of them are enabled. Ti disable particular category, add an entry with a `false` value"
}

variable "azurerm_monitor_diagnostic_setting_name" {
  type        = string
  default     = "amds-default"
  description = "Name of the diagnostic setting"
}

variable "consumption_budgets" {
  type        = map(any)
  default     = {}
  description = <<-EOT
    Consumption budget resources associated with this resource group, it should be a map of values:
    `{
      amount = number
      time_period = object
      notifications = map

      #optional
      time_grain = string
    }`
    `time_period` is an object of `start_date` (which is required) and `end_date` (which is optional).
    `time_grain` must be one of Monthly, Quarterly, Annually, BillingMonth, BillingQuarter, or BillingYear. Defaults to Monthly
    `notifications` is a map of values:
    `{
      #optional
      contact_emails = list(string)
      operator = string
      threshold = string
      threshold_type = string
    }`
    `contact_emails` is a list of email addresses to send the budget notification to when the threshold is exceeded
    `operator` - the comparison operator for the notification. Must be one of EqualTo, GreaterThan, or GreaterThanOrEqualTo. Defaults to `EqualTo`
    `threshold` - threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0 and 1000. Defaults to 90.
    `threshold_type` - the type of threshold for the notification. This determines whether the notification is triggered by forecasted costs or actual costs. The allowed values are Actual and Forecasted. Default is Actual.

    For more information, please visit: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group
    EOT
}

variable "default_consumption_budget_notification_emails" {
  type        = list(string)
  default     = []
  description = "List of e-mail addresses that will be used for notifications if they were not provided explicitly"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resource group"
  default     = {}
}