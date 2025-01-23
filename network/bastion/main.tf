#----------------------------------------------------------
# Resource Group, VNet, Subnet selection & Random Resources
#----------------------------------------------------------

resource "random_string" "str" {
  length  = 6
  special = false
  upper   = false
  keepers = {
    domain_name_label = var.azure_bastion_service_name
  }
}

#---------------------------------------------
# Public IP for Azure Bastion Service
#---------------------------------------------
resource "azurerm_public_ip" "pip" {
  name                = lower("${var.azure_bastion_service_name}-${var.location}-pip")
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  domain_name_label   = var.domain_name_label != null ? var.domain_name_label : format("gw%s%s", lower(replace(var.azure_bastion_service_name, "/[[:^alnum:]]/", "")), random_string.str.result)
  tags                = merge({ "ResourceName" = lower("${var.azure_bastion_service_name}-${var.location}-pip") }, var.tags, )

  lifecycle {
    ignore_changes = [
      tags,
      ip_tags,
    ]
  }
}

#---------------------------------------------
# Azure Bastion Service host
#---------------------------------------------
resource "azurerm_bastion_host" "main" {
  name                   = lower(var.azure_bastion_service_name)
  location               = var.location
  resource_group_name    = var.resource_group_name
  copy_paste_enabled     = var.enable_copy_paste
  file_copy_enabled      = var.bastion_host_sku == "Standard" ? var.enable_file_copy : null
  sku                    = var.bastion_host_sku
  ip_connect_enabled     = var.enable_ip_connect
  scale_units            = var.bastion_host_sku == "Standard" ? var.scale_units : 2
  shareable_link_enabled = var.bastion_host_sku == "Standard" ? var.enable_shareable_link : null
  tunneling_enabled      = var.bastion_host_sku == "Standard" ? var.enable_tunneling : null
  tags                   = merge({ "ResourceName" = lower(var.azure_bastion_service_name) }, var.tags, )

  ip_configuration {
    name                 = "${lower(var.azure_bastion_service_name)}-network"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}