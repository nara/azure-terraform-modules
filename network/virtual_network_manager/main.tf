module "naming_conv" {
  source = "../../foundation/naming_conv"
  #source = "git::https://github.com/nara-alz-org/modules.git//azure/foundation/naming_conv"
  app_key = var.app_key
  environment = var.environment
  line_of_business_key = var.line_of_business_key
  org_email_domain = var.org_email_domain
  org_key = var.org_key
  team_key = var.team_key
}

resource "azurerm_network_manager" "network_manager" {
  name                = "central-network-manager"
  location            = var.location
  resource_group_name = var.resource_group_name
  scope {
    management_group_ids = [var.management_group_id]
  }
  #scope_accesses = ["Connectivity", "SecurityAdmin"] #in preview at this time.
  scope_accesses = ["Connectivity"]
  description    = "central network manager"
}

resource "azurerm_network_manager_network_group" "network_group" {
  name               = "central-network-group"
  network_manager_id = azurerm_network_manager.network_manager.id
}

resource "azurerm_network_manager_management_group_connection" "group_connection" {
  name                = "example-nmmgc"
  management_group_id = var.management_group_id
  network_manager_id  = azurerm_network_manager.network_manager.id
  description         = "Central network manager management group connection"
}

#in preview at this time.
# resource "azurerm_network_manager_security_admin_configuration" "admin_config" {
#   name                                          = "example-admin-conf"
#   network_manager_id                            = azurerm_network_manager.network_manager.id
#   description                                   = "example admin conf"
#   apply_on_network_intent_policy_based_services = ["All"]
# }

resource "azurerm_network_manager_connectivity_configuration" "connectivity_config" {
  name                  = "example-connectivity-conf"
  network_manager_id    = azurerm_network_manager.network_manager.id
  connectivity_topology = "HubAndSpoke"
  applies_to_group {
    group_connectivity = "None"
    network_group_id   = azurerm_network_manager_network_group.network_group.id
  }
  hub {
    resource_id   = var.hub_vnet_id
    resource_type = "Microsoft.Network/virtualNetworks"
  }
}

resource "azurerm_network_manager_deployment" "manager_deployment" {
  network_manager_id = azurerm_network_manager.network_manager.id
  location           = var.location
  scope_access       = "Connectivity"
  configuration_ids  = [azurerm_network_manager_connectivity_configuration.connectivity_config.id]
}