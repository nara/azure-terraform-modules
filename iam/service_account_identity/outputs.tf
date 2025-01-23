output "user_assigned_identity_id" {
    value = var.create_user_identity ? azurerm_user_assigned_identity.identity[0].id : null
}