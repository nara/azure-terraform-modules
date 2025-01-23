resource "azurerm_cdn_frontdoor_profile" "profile" {
  count = var.cdn_frontdoor_profile_id == "" ? 1 : 0
  name                     = "${module.naming_conv.naming_for_app.frontdoor.name}-prfl"
  resource_group_name      = module.naming_conv.naming_for_app.resource_group.name
  sku_name                 = var.sku_name
  response_timeout_seconds = var.response_timeout_seconds
  tags                     = var.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  count = var.cdn_frontdoor_endpoint_id == "" ? 1 : 0
  name                     = "${module.naming_conv.naming_for_app.frontdoor.name}-endpnt"
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id != "" ? var.cdn_frontdoor_profile_id : azurerm_cdn_frontdoor_profile.profile[0].id
  tags                     = var.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "origin_group" {
  count = var.cdn_frontdoor_origin_group_id == "" ? 1 : 0

  name                     = "${module.naming_conv.naming_for_app.frontdoor.name}-orggrp"
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id != "" ? var.cdn_frontdoor_profile_id : azurerm_cdn_frontdoor_profile.profile[0].id

  dynamic "load_balancing" {
    for_each = var.load_balancing != null ? [var.load_balancing] : []
    content {
      additional_latency_in_milliseconds = lookup(load_balancing.value, "additional_latency_in_milliseconds", null)
      sample_size                        = lookup(load_balancing.value, "sample_size", null)
      successful_samples_required        = lookup(load_balancing.value, "successful_samples_required", null)
    }
  }

  dynamic "health_probe" {
    for_each = var.health_probe != null ? [var.health_probe] : []
    content {
      protocol            = lookup(health_probe.value, "protocol", null)
      interval_in_seconds = lookup(health_probe.value, "interval_in_seconds", null)
      request_type        = lookup(health_probe.value, "request_type", null)
      path                = lookup(health_probe.value, "path", null)
    }
  }
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = var.restore_traffic_time_to_healed_or_new_endpoint_in_minutes
  session_affinity_enabled                                  = var.session_affinity_enabled
}


resource "azurerm_cdn_frontdoor_origin" "origin" {
  for_each = { for origin in var.cdn_frontdoor_origins : origin.name => origin }
  name                           = each.value.name
  cdn_frontdoor_origin_group_id  = var.cdn_frontdoor_origin_group_id != "" ? var.cdn_frontdoor_origin_group_id : azurerm_cdn_frontdoor_origin_group.origin_group[0].id
  host_name                      = each.value.host_name
  certificate_name_check_enabled = each.value.certificate_name_check_enabled
  enabled                        = each.value.enabled
  http_port                      = each.value.http_port
  https_port                     = each.value.https_port
  origin_host_header             = each.value.origin_host_header
  priority                       = each.value.priority
  weight = each.value.weight

  dynamic "private_link" {
    for_each = each.value.private_link != null ? [each.value.private_link] : []
    content {
      request_message        = lookup(private_link.value, "request_message", null)
      target_type            = lookup(private_link.value, "target_type", null)
      location               = lookup(private_link.value, "location", null)
      private_link_target_id = lookup(private_link.value, "private_link_target_id", null)
    }
  }
}

resource "azurerm_cdn_frontdoor_route" "example" {
  name                          = "${module.naming_conv.naming_for_app.frontdoor.name}-route"
  cdn_frontdoor_endpoint_id     = var.cdn_frontdoor_endpoint_id != "" ? var.cdn_frontdoor_endpoint_id : azurerm_cdn_frontdoor_endpoint.endpoint[0].id
  cdn_frontdoor_origin_group_id = var.cdn_frontdoor_origin_group_id != "" ? var.cdn_frontdoor_origin_group_id : azurerm_cdn_frontdoor_origin_group.origin_group[0].id
  cdn_frontdoor_origin_ids      = [for origin in var.cdn_frontdoor_origins : azurerm_cdn_frontdoor_origin.origin[origin.name].id]
  forwarding_protocol           = var.forwarding_protocol
  patterns_to_match             = var.patterns_to_match
  supported_protocols           = var.supported_protocols

  dynamic "cache" {
    for_each = var.cache != null ? [var.cache] : []
    content {
      query_string_caching_behavior = lookup(cache.value, "query_string_caching_behavior", null)
      query_strings                 = lookup(cache.value, "query_strings", null)
      compression_enabled           = lookup(cache.value, "compression_enabled", null)
      content_types_to_compress     = lookup(cache.value, "content_types_to_compress", null)

    }
  }
  cdn_frontdoor_custom_domain_ids = var.cdn_frontdoor_custom_domain_ids
  cdn_frontdoor_origin_path       = var.cdn_frontdoor_origin_path
  cdn_frontdoor_rule_set_ids      = var.cdn_frontdoor_rule_set_ids
  enabled                         = var.enabled
  https_redirect_enabled          = var.https_redirect_enabled
  link_to_default_domain          = var.link_to_default_domain
  
}