variable "app_name" {
  description = "App name"
  type        = string
}

variable "app_registration_name" {
  description = "App registration name"
  type        = string
}

variable "user_assigned_identity_name" {
  description = "User assigned identity name"
  type        = string
  default = ""
}

variable "location_short" {
  description = "Location Short form"
  type        = string
}

variable "environment" {
  description = "A max 4 letter word explaining the environment the resources belong to. e.g. dev, qa, uat, stg, prod"
  type        = string
}

variable "location" {
  description = "Region"
  type        = string
  default = ""
}

variable "create_user_identity" {
  description = "Create user identity for this app"
  type = bool
  default = true
}

variable "assign_roles_to_sa" {
  description = "Assign roles to service account. ex: { scope = role }"
  type        = map(string)
  default = {}
}

variable "assign_roles_to_user_identity" {
  description = "Assign roles to user identity. ex: { scope = role }"
  type        = map(string)
  default = {}
}

variable "key_vault_id" {
  description = "Key vault id"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}