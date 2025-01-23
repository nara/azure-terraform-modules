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
  description = "environment value."
  type        = string
  default = "dev"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to be imported."
  default = ""
}

variable "location" {
  type        = string
  description = "The location of the vnet to create."
  nullable    = false
}

#create a variable management_group_id
variable "management_group_id" {
  type        = string
  description = "The management group id to assign the vnet to."
  default = ""
}

#variable hub_vnet_id
variable "hub_vnet_id" {
  type        = string
  description = "The hub vnet id to peer with."
  default = ""
}

variable "tagName" {
  type        = string
  description = "The tag name to use for dynamic assignments"
}

variable "tagValues" {
  type        = list(string)
  description = "The tag values to use for dynamic assignments"
}