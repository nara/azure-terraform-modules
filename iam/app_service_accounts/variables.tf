
variable "org_key" {
  description = "The organization 3 letter word"
  type        = string
}

variable "org_email_domain" {
  description = "The organization domain (e.g. example.com )"
  type        = string
}

variable "line_of_business_key" {
  description = "A 3 letter word for line of business that is unique in org"
  type        = string
}

variable "team_key" {
  description = "Opitonal. A 3 letter word for team managing the resources in this project"
  type        = string
  default = ""
}

variable "location_short" {
  description = "Location Short form"
  type        = string
}

variable "host_or_service_proj" {
  description = "Is this a host or service project. Accepted values host or svc"
  type        = string
  default = "host"
}

variable "app_key" {
  description = "A 3 letter app key that is unique in org"
  type        = string
}

variable "environment" {
  description = "A max 4 letter word explaining the environment the resources belong to. e.g. dev, qa, uat, stg, prod"
  type        = string
}

variable "capabilities" {
  description = "List of capabilities to add as permissions for roles. Values kms, secretmanager, serverless_connector, cloudrun, loadbalancer"
  type = list(string)
  default = []
}

variable "key_vault_id" {
  description = "Key Vault Id to store azuread app client secrets"
  type        = string
  default = ""
}

variable "app_layers" {
  type = list(string)
  default = []
  description = "layers in this app: web, app, data etc."
}