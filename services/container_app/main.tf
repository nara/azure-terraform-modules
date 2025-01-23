resource "azurerm_container_app_environment" "managed_environment" {
  name                           = var.managed_environment_name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.log_analytics_workspace.id
  infrastructure_subnet_id       = var.infrastructure_subnet_id
  internal_load_balancer_enabled = var.internal_load_balancer_enabled
  tags                           = var.tags
  
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_container_app" "container_app" {
  for_each                     = {for app in [var.container_app]: app.name => app}

  name                         = each.key
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.managed_environment.id
  tags                         = var.tags
  revision_mode                = each.value.revision_mode

  template {
    dynamic "container" {
      for_each                   = coalesce(each.value.template.containers, [])
      content {
        name                     = container.value.name
        image                    = container.value.image
        args                     = try(container.value.args, null)
        command                  = try(container.value.command, null)
        cpu                      = container.value.cpu
        memory                   = container.value.memory
        
        dynamic "env" {
          for_each               = coalesce(container.value.env, [])
          content {
            name                 = env.value.name
            secret_name          = try(env.value.secret_name, null)
            value                = try(env.value.value, null)
          }
        }
      }
    }
    min_replicas                 = try(each.value.template.min_replicas, null)
    max_replicas                 = try(each.value.template.max_replicas, null)
    revision_suffix              = try(each.value.template.revision_suffix, null)

    dynamic "volume" {
      for_each                   = each.value.template.volume != null ? [each.value.template.volume] : []
      content {
        name                     = volume.value.name
        storage_name             = try(volume.value.storage_name, null)
        storage_type             = try(volume.value.storage_type, null)
      }
    }
  }

 dynamic "ingress" {
    for_each                     = each.value.ingress != null ? [each.value.ingress] : []
    content {
      allow_insecure_connections = try(ingress.value.allow_insecure_connections, null)
      external_enabled           = try(ingress.value.external_enabled, null)
      target_port                = ingress.value.target_port
      transport                  = ingress.value.transport

      dynamic "traffic_weight"  {
        for_each                 = coalesce(ingress.value.traffic_weight, [])
        content {
          label                  = traffic_weight.value.label
          latest_revision        = traffic_weight.value.latest_revision
          revision_suffix        = traffic_weight.value.revision_suffix
          percentage             = traffic_weight.value.percentage
        }
      }
    }
  }

  dynamic "dapr" {
    for_each                     = each.value.dapr != null ? [each.value.dapr] : []
    content {
      app_id                     = dapr.value.app_id
      app_port                   = dapr.value.app_port
      app_protocol               = dapr.value.app_protocol
    }
  }

  dynamic "secret" {
    for_each                     = each.value.secrets != null ? [each.value.secrets] : []
    content {
      name                       = secret.value.name
      value                      = secret.value.value
    }
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_application_insights" "resource" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
  application_type    = "web"
  workspace_id        = var.workspace_id

  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  tags                = local.tags
  retention_in_days   = var.retention_in_days != "" ? var.retention_in_days : null

  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_service_vnet_integration" {
  count          = var.app_service_vnet_integration_subnet_id == null ? 0 : 1
  app_service_id = azurerm_container_app.container_app[0].id
  subnet_id      = var.app_service_vnet_integration_subnet_id
}

# resource "azurerm_app_service_slot_virtual_network_swift_connection" "app_service_slot_vnet_integration" {
#   count          = var.staging_slot_enabled && var.app_service_vnet_integration_subnet_id != null ? 1 : 0
#   slot_name      = azurerm_linux_web_app_slot.app_service_linux_container_slot[0].name
#   app_service_id = azurerm_linux_web_app.container_app.id
#   subnet_id      = var.app_service_vnet_integration_subnet_id
# }