resource "azurerm_key_vault_secret" "secret" {
  for_each = { for secret in var.secret_data : secret.name => secret }
  name         = each.key
  value        = each.value.value
  key_vault_id = var.key_vault_id
  content_type =  each.value.content_type
  tags         = var.tags
  not_before_date =  each.value.not_before_date
  expiration_date = each.value.expiration_date
}