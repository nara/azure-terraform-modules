terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.40, < 4.0"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
}