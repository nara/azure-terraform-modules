output "group_ids" {
    description = "Group ids"
    value       = {for key in local.groups : key => azuread_group.ad_groups[key].id}
}