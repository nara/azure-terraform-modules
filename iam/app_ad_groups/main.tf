#sa
resource "azuread_group" "ad_groups" {
  for_each = toset(local.groups)
  display_name     = format("%s-%s", var.group_prefix, each.value)
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}