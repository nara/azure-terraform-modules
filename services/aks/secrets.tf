
module "secrets" {
    source     = "git::https://github.com/nara-alz-org/modules.git//azure/security/secret"
    
    location = var.location
    key_vault_id = var.keyvault_id

    secret_data = concat(
      [{
            name = "${var.naming_prefix}-aks-host",
            value = azurerm_kubernetes_cluster.main.kube_admin_config.0.host
        },
        {
            name = "${var.naming_prefix}-aks-client-certificate",
            value = base64decode(azurerm_kubernetes_cluster.main.kube_admin_config.0.client_certificate)
        },
        {
            name = "${var.naming_prefix}-aks-client-key",
            value = base64decode(azurerm_kubernetes_cluster.main.kube_admin_config.0.client_key)
        },
        {
            name = "${var.naming_prefix}-aks-cluster-ca-certificate",
            value = base64decode(azurerm_kubernetes_cluster.main.kube_admin_config.0.cluster_ca_certificate)
        }]
    )
}
