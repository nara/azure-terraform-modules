locals {
  location_short = lookup(local.region_short_codes, var.location, var.location)
  common_suffix = flatten([ var.environment, local.location_short, var.naming_postfix != "" ? [ var.naming_postfix ] : []])
  layer_suffix = flatten([ var.app_key, var.layer_key, local.common_suffix])
  app_suffix = flatten([ var.app_key, local.common_suffix ])
  team_suffix = flatten([ var.line_of_business_key, var.team_key, local.common_suffix])
  central_suffix = flatten([ var.line_of_business_key, local.common_suffix])
}