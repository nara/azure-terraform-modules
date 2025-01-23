locals {
  common_suffix = module.naming_suffix.common_suffix_list
  layer_suffix = module.naming_suffix.suffix_for_layer_list
  app_suffix = module.naming_suffix.suffix_for_app_list
  team_suffix = module.naming_suffix.suffix_for_team_list
  central_suffix = module.naming_suffix.suffix_for_central_list
}

module "naming_suffix" {
  source = "../naming_suffix"
  app_key = var.app_key
  db_type = var.db_type
  environment = var.environment
  layer_key = var.layer_key
  line_of_business_key = var.line_of_business_key
  location = var.location
  location_short = var.location_short
  naming_postfix = var.naming_postfix
  org_email_domain = var.org_email_domain
  org_key = var.org_key
  team_key = var.team_key
  vpc_postfix = var.vpc_postfix
}

module "naming_for_layer" {
  source  = "Azure/naming/azurerm"
  suffix = local.layer_suffix
}

module "naming_for_app" {
  source  = "Azure/naming/azurerm"
  suffix = local.app_suffix
}

module "naming_for_team" {
  source  = "Azure/naming/azurerm"
  suffix = local.team_suffix
}

module "naming_for_central" {
  source  = "Azure/naming/azurerm"
  suffix = local.central_suffix
}