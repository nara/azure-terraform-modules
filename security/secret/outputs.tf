output "ids" {
  value = { for secret in azurerm_key_vault_secret.secret : secret.name => secret.id }
}