locals {
  default_permissions = ["Microsoft.OperationalInsights/workspaces/read", ]

  default_permissions_write = []

  kv_permissions_read = [
    "Microsoft.KeyVault/vaults/*/read",
    "Microsoft.KeyVault/operations/read",
    "Microsoft.KeyVault/checkNameAvailability/read",
    "Microsoft.KeyVault/deletedVaults/read",
    "Microsoft.KeyVault/locations/*/read"]

  kv_permissions_write = [
    
  ]

  data_kv_secrets_read = [
    "Microsoft.KeyVault/vaults/secrets/getSecret/action",
    "Microsoft.KeyVault/vaults/secrets/readMetadata/action",
    # "Microsoft.KeyVault/vaults/secrets/read",
    # "Microsoft.KeyVault/vaults/secrets/list",
    # "Microsoft.KeyVault/vaults/secrets/versions/read",
    # "Microsoft.KeyVault/vaults/secrets/versions/list",
  ]

  netowrk_permissions_read = [
    "Microsoft.Network/privateEndpoints/read",
    "Microsoft.Resources/subscriptions/resourceGroups/read",
    "Microsoft.Network/virtualNetworks/read",
    "Microsoft.Network/virtualNetworks/subnets/read",
    "Microsoft.Network/locations/availablePrivateEndpointTypes/read",
  ]

  network_permissions_write = [
    "Microsoft.Network/privateEndpoints/write",
    "Microsoft.Network/privateEndpoints/delete",
    "Microsoft.Network/virtualNetworks/subnets/join/action",
    "Microsoft.Network/virtualNetworks/join/action",
    "Microsoft.Automation/automationAccounts/privateEndpointConnections/write",
    # "Microsoft.Network/virtualNetworks/*",
    # "Microsoft.Network/virtualNetworks/subnets/*",
    "Microsoft.Network/privateEndpoints/*",
    # "Microsoft.Network/networkinterfaces/*",
    # "Microsoft.ApiManagement/service/*",
    # "Microsoft.ApiManagement/service/privateEndpointConnections/*",
    # "Microsoft.Resources/deployments/*",
    "Microsoft.Network/virtualNetworks/subnets/write"
  ]

  vpc_permissions_write = [
  ]

  app_service_read = [
    "Microsoft.Web/serverfarms/read",
    "Microsoft.Web/sites/read",
    "Microsoft.Web/sites/config/read",
    "Microsoft.Web/sites/config/list/action"
  ]

  app_service_write = [
    "Microsoft.Web/sites/write",
    "Microsoft.Web/sites/delete",
    "Microsoft.Web/sites/config/write",
    "Microsoft.Web/sites/config/delete",
    "Microsoft.Web/serverfarms/write",
    "Microsoft.Web/serverfarms/delete",
  ]

  loadbalancer_dns_read = [
    "Microsoft.Network/privateDnsZones/read",
    "Microsoft.Network/privateDnsZones/SOA/read",
    "Microsoft.Network/privateDnsZones/A/read",
    "Microsoft.Network/privateDnsZones/virtualNetworkLinks/read"
  ]

  loadbalancer_dns_write = [
    "Microsoft.Network/privateDnsZones/write",
    "Microsoft.Network/privateDnsZones/delete",
    "Microsoft.Network/privateDnsZones/A/write",
    "Microsoft.Network/privateDnsZones/virtualNetworkLinks/write",
    "Microsoft.Network/privateDnsZones/virtualNetworkLinks/delete"
  ]

  db_permissions_read = [
    "Microsoft.DBforPostgreSQL/flexibleServers/read",
    "Microsoft.DBforPostgreSQL/flexibleServers/databases/read",
    "Microsoft.DBforPostgreSQL/servers/databases/read",
    "Microsoft.DBforPostgreSQL/servers/read",
    "Microsoft.DBforPostgreSQL/servers/securityAlertPolicies/read"
  ]

  db_postgres_write = [
    "Microsoft.DBforPostgreSQL/flexibleServers/write",
    "Microsoft.DBforPostgreSQL/flexibleServers/delete",
    "Microsoft.DBforPostgreSQL/flexibleServers/databases/write",
    "Microsoft.DBforPostgreSQL/servers/databases/write",
    "Microsoft.DBforPostgreSQL/servers/write",
    "Microsoft.DBforPostgreSQL/servers/delete",
    "Microsoft.DBforPostgreSQL/servers/databases/delete",
    "Microsoft.DBforPostgreSQL/servers/privateEndpointConnectionsApproval/action"
  ]
  
  log_analytics_write = [
    "Microsoft.Insights/components/read",
    "Microsoft.OperationalInsights/workspaces/write",
    "Microsoft.OperationalInsights/workspaces/delete",
    "Microsoft.Insights/components/write",
    "Microsoft.Insights/components/currentbillingfeatures/write",
    "Microsoft.Web/serverfarms/write"
  ]

  db_permissions_write = concat(local.default_permissions, (contains(var.capabilities, "tet") ? local.kv_permissions_read : []),
    (contains(var.capabilities, "db_postgres") ? local.db_postgres_write : []),
    (contains(var.capabilities, "appsvc") ? local.app_service_read : []),
    (contains(var.capabilities, "kv_secrets") ? local.kv_permissions_read : []),
    (contains(var.capabilities, "serverless_connector") ? local.netowrk_permissions_read : []),
    (contains(var.capabilities, "loadbalancer") ? local.loadbalancer_dns_read : []))

  all_permissions_read = concat(local.default_permissions, (contains(var.capabilities, "kv_certs") ? local.kv_permissions_read : []),
    (contains(var.capabilities, "private_endpoint") ? local.netowrk_permissions_read : []),
    (contains(var.capabilities, "db_postgres") ? local.db_permissions_read : []),
    (contains(var.capabilities, "appsvc") ? local.app_service_read : []),
    (contains(var.capabilities, "kv_secrets") ? local.kv_permissions_read : []),
    (contains(var.capabilities, "serverless_connector") ? local.netowrk_permissions_read : []),
    (contains(var.capabilities, "loadbalancer") ? local.loadbalancer_dns_read : []))

  data_all_permissions_read = concat((contains(var.capabilities, "kv_secrets") ? local.data_kv_secrets_read : []),
    )
  
  security_permissions_write = concat( (contains(var.capabilities, "kms") ? local.kv_permissions_write : []),
    (contains(var.capabilities, "secretmanager") ? local.kv_permissions_write : []))

  preglobal_permissions_write = concat( (contains(var.capabilities, "secretmanager") ? local.kv_permissions_write : []))

  postglobal_permissions_write = concat( (contains(var.capabilities, "secretmanager") ? local.kv_permissions_write : []))

  regional_permissions_write = concat(local.log_analytics_write , (contains(var.capabilities, "db_postgres") ? local.db_permissions_write : []),
    (contains(var.capabilities, "loadbalancer") ? local.loadbalancer_dns_write : []),
    (contains(var.capabilities, "appsvc") ? local.app_service_write : []),
    (contains(var.capabilities, "private_endpoint") ? local.network_permissions_write : []))

  service_permissions_write = concat( (contains(var.capabilities, "serverless_connector") ? 
        ["compute.regionNetworkEndpointGroups.create", "compute.regionNetworkEndpointGroups.delete"] : []),
    (contains(var.capabilities, "cloudrun") ? ["run.services.create", "run.services.update", "run.services.get"] : []),
    (contains(var.capabilities, "secretmanager") ? local.kv_permissions_write : []))

  
  global_permissions_write = concat( (contains(var.capabilities, "loadbalancer") ? 
        ["compute.globalAddresses.create", "compute.securityPolicies.create", 
        "compute.securityPolicies.delete", "compute.globalAddresses.delete", "compute.backendServices.create", 
        "compute.backendServices.setSecurityPolicy", "compute.backendServices.delete", "compute.urlMaps.create", "compute.urlMaps.delete",
        "compute.globalForwardingRules.create", "compute.globalForwardingRules.setLabels", 
        "compute.targetHttpProxies.create", "compute.targetHttpProxies.delete",
        "compute.globalForwardingRules.delete", "compute.targetHttpProxies.setUrlMap", 
        "compute.sslCertificates.create", "compute.sslCertificates.delete", 
        "compute.targetHttpsProxies.create", "compute.targetHttpsProxies.delete"] : []),
        (contains(var.capabilities, "secretmanager") ? local.kv_permissions_write : []))
}