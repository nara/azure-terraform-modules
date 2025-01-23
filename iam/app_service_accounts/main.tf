data "azurerm_subscription" "primary" {
}

module "layer_accounts" {
  source = "./layer_accounts"
  for_each = { for layer in var.app_layers : layer => layer }
  app_key = var.app_key
  environment = var.environment
  line_of_business_key = var.line_of_business_key
  org_email_domain = var.org_email_domain
  org_key = var.org_key
  layer_key = each.value
  key_vault_id = var.key_vault_id
  location_short = var.location_short
}

