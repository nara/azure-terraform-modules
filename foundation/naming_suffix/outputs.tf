output "common_suffix_list"{
  value = local.common_suffix
}

output "suffix_for_layer_list"{
  value = local.layer_suffix
}

output "suffix_for_app_list"{
  value = local.app_suffix
}

output "suffix_for_team_list"{
  value = local.team_suffix
}

output "suffix_for_central_list"{
  value = local.central_suffix
}

output "common_suffix"{
  value = join("-", local.common_suffix)
}

output "suffix_for_layer"{
  value = join("-", local.layer_suffix)
}

output "suffix_for_app"{
  value = join("-", local.app_suffix)
}

output "private_endpoint_url" {
  value = "${var.app_key}.${var.location_short}.${var.environment}.${var.org_key}.com"
}

output "suffix_for_team"{
  value = join("-", local.team_suffix)
}

output "suffix_for_central"{
  value = join("-", local.central_suffix)
}

output "location_short" {
  value = local.location_short
}